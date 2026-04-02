using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHoa.Models;
using WebBanHoa.ViewModel;

namespace WebBanHoa.Controllers
{
    public class CartController : Controller
    {
        //
        // GET: /Cart/
        // GET: /Cart/
        public EFFirstDatabaseEntities db = new EFFirstDatabaseEntities();
        public ActionResult Index()
        {
            if (Session["MaKH"] == null)
            {
                return RedirectToAction("Login", "Account");
            }

            string maKH = Session["MaKH"].ToString();

            // Tìm giỏ hàng hiện tại của khách hàng
            GIOHANG gioHang = db.GIOHANGs.SingleOrDefault(gh => gh.MaKH == maKH);

            if (gioHang == null)
            {
                // Nếu không có giỏ hàng, trả về View rỗng
                return View(new List<Chitietgiohang>());
            }

            // Thực hiện truy vấn LINQ để JOIN 3 bảng: GIOHANG, CHITIET_GIOHANG, HOA
            var cartDetails = from ct in db.CHITIET_GIOHANG
                              join hoa in db.HOAs on ct.MaHoa equals hoa.MaHoa
                              where ct.MaGH == gioHang.MaGH
                              select new Chitietgiohang
                              {
                                  MaHoa = ct.MaHoa,
                                  TenHoa = hoa.TenHoa,
                                  Gia = hoa.Gia,
                                  SoLuong = (int)ct.SoLuong,
                                  HinhAnh = hoa.HinhAnh
                              };

            List<Chitietgiohang> danhSach = cartDetails.ToList();

            // Bạn có thể truyền thẳng List<ChiTietGioHangViewModel> sang View
            return View(danhSach);
        }
        [HttpPost]
        public ActionResult ThemGioHang(string maHoa, int soLuong = 1)
        {
            // Bước 1: Kiểm tra đăng nhập và lấy MaKH (Mã Khách Hàng)
            if (Session["MaKH"] == null)
            {
                // Nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
                return Json(new { success = false, message = "Vui lòng đăng nhập để thêm sản phẩm." });
                // Hoặc có thể dùng: return RedirectToAction("DangNhap", "TaiKhoan"); 
            }

            string maKH = Session["MaKH"].ToString();

            // Kiểm tra số lượng hợp lệ (tối thiểu 1)
            if (soLuong < 1)
            {
                soLuong = 1;
            }

            // Bước 3 & 4: Tìm hoặc Tạo Giỏ Hàng (GIOHANG)
            GIOHANG gioHang = db.GIOHANGs.SingleOrDefault(gh => gh.MaKH == maKH);
            if (gioHang == null)
            {
                // Tạo Giỏ Hàng mới nếu chưa tồn tại
                gioHang = new GIOHANG
                {
                    MaKH = maKH,
                    NgayTao = System.DateTime.Now
                    // Giả sử MaGH được tự động tạo (Auto-increment)
                };
                db.GIOHANGs.Add(gioHang);
                try
                {
                    db.SaveChanges(); // Lỗi xảy ra ở đây
                }
                catch (System.Data.Entity.Validation.DbEntityValidationException ex)
                {
                    // ⚠️ Đặt breakpoint ở đây, sau đó mở cửa sổ Watch
                    var errorMessages = ex.EntityValidationErrors
                        .SelectMany(x => x.ValidationErrors)
                        .Select(x => x.ErrorMessage);

                    var fullError = string.Join("; ", errorMessages);

                    // Bạn sẽ thấy lỗi chi tiết trong biến 'fullError'
                    throw new Exception(fullError);
                }
            }

            // Lấy MaGH vừa tìm được/tạo ra
            int maGH = (int)gioHang.MaGH;

            // Bước 5 & 6: Tìm và Cập nhật/Thêm mới Chi tiết Giỏ Hàng (CHITIET_GIOHANG)
            CHITIET_GIOHANG chiTiet = db.CHITIET_GIOHANG.SingleOrDefault(ct => ct.MaGH == maGH && ct.MaHoa == maHoa);

            if (chiTiet != null)
            {
                // Cập nhật số lượng nếu sản phẩm đã có trong giỏ
                chiTiet.SoLuong += soLuong;
            }
            else
            {
                // Thêm mới chi tiết giỏ hàng
                chiTiet = new CHITIET_GIOHANG
                {
                    MaGH = maGH,
                    MaHoa = maHoa,
                    SoLuong = soLuong
                };
                db.CHITIET_GIOHANG.Add(chiTiet);
            }

            // Bước 7: Lưu thay đổi vào Database
            try
            {
                db.SaveChanges(); // Lỗi xảy ra ở đây
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                // ⚠️ Đặt breakpoint ở đây, sau đó mở cửa sổ Watch
                var errorMessages = ex.EntityValidationErrors
                    .SelectMany(x => x.ValidationErrors)
                    .Select(x => x.ErrorMessage);

                var fullError = string.Join("; ", errorMessages);

                // Bạn sẽ thấy lỗi chi tiết trong biến 'fullError'
                throw new Exception(fullError);
            }
            var cartDetails = db.CHITIET_GIOHANG
                         .Where(ct => ct.MaGH == maGH)
                         .ToList();
            int tongSoLuong = cartDetails
                         .Sum(ct => ct.SoLuong.GetValueOrDefault()); // Chắc chắn dùng GetValueOrDefault()

            // Trả về thông báo thành công VÀ tổng số lượng mới
            return Json(new
            {
                success = true,
                message = "Đã thêm sản phẩm vào giỏ hàng thành công!",
                totalQuantity = tongSoLuong // <--- TRẢ VỀ TỔNG SỐ LƯỢNG
            });
        }
        // CẬP NHẬT SỐ LƯỢNG
        public ActionResult UpdateQuantity(string proid, string type)
        {
            string maGH = Session["MaGH"] as string;

            if (string.IsNullOrEmpty(maGH))
                return RedirectToAction("Index", "Home");

            var cartItem = db.CHITIET_GIOHANG
                             .FirstOrDefault(x => x.MaGH == int.Parse(maGH) && x.MaHoa == proid);

            if (cartItem != null)
            {
                if (type == "plus")
                    cartItem.SoLuong++;

                if (type == "minus" && cartItem.SoLuong > 1)
                    cartItem.SoLuong--;

                db.SaveChanges();
            }

            return RedirectToAction("Index");
        }

        // XÓA SẢN PHẨM
        [HttpPost]
        public ActionResult Delete(string maHoa )
        {
            if (Session["MaKH"] == null)
            {
                return Json(new { success = false, message = "Vui lòng đăng nhập để xóa sản phẩm." });
            }

            string maKH = Session["MaKH"].ToString();

            // Bước 2: Tìm Giỏ Hàng của khách hàng
            GIOHANG gioHang = db.GIOHANGs.SingleOrDefault(gh => gh.MaKH == maKH);

            if (gioHang == null)
            {
                return Json(new { success = false, message = "Giỏ hàng của bạn đang trống." });
            }

            int maGH = gioHang.MaGH; // Lấy MaGH (kiểu int)

            // Bước 3: Tìm Chi Tiết Giỏ Hàng cần xóa
            CHITIET_GIOHANG chiTietCanXoa = db.CHITIET_GIOHANG.SingleOrDefault(
                ct => ct.MaGH == maGH && ct.MaHoa == maHoa
            );

            if (chiTietCanXoa == null)
            {
                return Json(new { success = false, message = "Sản phẩm không có trong giỏ hàng." });
            }

            // Bước 4: Xóa sản phẩm và lưu thay đổi
            try
            {
                db.CHITIET_GIOHANG.Remove(chiTietCanXoa);
                db.SaveChanges();

                // Sau khi xóa, tính toán lại tổng số lượng (để cập nhật icon)
                int tongSoLuongMoi = db.CHITIET_GIOHANG
                                       .Where(ct => ct.MaGH == maGH)
                                       .Sum(ct => ct.SoLuong.GetValueOrDefault());

                return Json(new { success = true, message = "Đã xóa sản phẩm khỏi giỏ hàng thành công!", totalQuantity = tongSoLuongMoi });
            }
            catch (Exception ex)
            {
                // Ghi log lỗi nếu cần
                return Json(new { success = false, message = "Lỗi khi thực hiện xóa sản phẩm: " + ex.Message });
            }
        }
        public ActionResult Checkout()
        {
            var carts = db.CHITIET_GIOHANG.ToList();
            if (!carts.Any())
                return RedirectToAction("Index");

            return View();
        }
    }
}