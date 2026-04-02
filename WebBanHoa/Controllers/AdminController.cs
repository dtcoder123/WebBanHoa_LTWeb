using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using WebBanHoa.Models;

namespace WebBanHoa.Controllers
{
    [RoutePrefix("Admin")]
    public class AdminController : Controller
    {
        // GET: Admin
        private EFFirstDatabaseEntities db = new EFFirstDatabaseEntities();
        [Route("TrangChu")]
        public ActionResult Trangchu()
        {
            return View();
        }
        [Route("QuanLySanPham")]
        public ActionResult QuanLySanPham()
        {
            ViewBag.Title = "Quản lý Sản phẩm Hoa";
            // Tải HOA và LOAIHOA liên quan (Eager Loading)
            var listHoa = db.HOAs.Include(h => h.LOAIHOA).ToList();
            return View(listHoa);
        }

        // ====================================================
        // 2. GET & POST: /Admin/ThemSanPham
        // ====================================================
        [HttpGet]
        [Route("ThemSanPham")]
        public ActionResult ThemSanPham()
        {
            ViewBag.Title = "Thêm Sản Phẩm Mới";
            ViewBag.MaLoai = new SelectList(db.LOAIHOAs, "MaLoai", "TenLoai");
            return View();
        }

        [HttpPost]
        [Route("ThemSanPham")]
        [ValidateAntiForgeryToken]
        public ActionResult ThemSanPham([Bind(Include = "MaHoa, TenHoa, MaLoai, Gia, SoLuongTon, MoTa, HinhAnh, TrangThai")] HOA hoa)
        {
            if (ModelState.IsValid)
            {
                // Logic tạo MaHoa... (giữ nguyên logic trước)
                if (string.IsNullOrEmpty(hoa.MaHoa))
                {
                    string lastMaHoa = db.HOAs.OrderByDescending(h => h.MaHoa).Select(h => h.MaHoa).FirstOrDefault();
                    int newId = (lastMaHoa != null && lastMaHoa.StartsWith("H") ? int.Parse(lastMaHoa.Substring(1)) : 0) + 1;
                    hoa.MaHoa = "H" + newId.ToString("D3");
                }

                db.HOAs.Add(hoa);
                db.SaveChanges();
                TempData["SuccessMessage"] = "Thêm sản phẩm [" + hoa.TenHoa + "] thành công!";
                return RedirectToAction("QuanLySanPham");
            }

            ViewBag.MaLoai = new SelectList(db.LOAIHOAs, "MaLoai", "TenLoai", hoa.MaLoai);
            return View(hoa);
        }

        // ====================================================
        // 3. GET & POST: /Admin/SuaSanPham/{id}
        // ====================================================
        [HttpGet]
        [Route("SuaSanPham/{id}")]
        public ActionResult SuaSanPham(string id)
        {
            if (id == null) return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            HOA hoa = db.HOAs.Find(id);
            if (hoa == null) return HttpNotFound();

            ViewBag.Title = "Sửa Sản Phẩm: " + hoa.TenHoa;
            ViewBag.MaLoai = new SelectList(db.LOAIHOAs, "MaLoai", "TenLoai", hoa.MaLoai);
            return View(hoa);
        }

        [HttpPost]
        [Route("SuaSanPham/{id}")]
        [ValidateAntiForgeryToken]
        public ActionResult SuaSanPham([Bind(Include = "MaHoa, TenHoa, MaLoai, Gia, SoLuongTon, MoTa, HinhAnh, TrangThai")] HOA hoa)
        {
            if (ModelState.IsValid)
            {
                db.Entry(hoa).State = EntityState.Modified;
                db.SaveChanges();
                TempData["SuccessMessage"] = "Cập nhật sản phẩm [" + hoa.TenHoa + "] thành công!";
                return RedirectToAction("QuanLySanPham");
            }
            ViewBag.MaLoai = new SelectList(db.LOAIHOAs, "MaLoai", "TenLoai", hoa.MaLoai);
            return View(hoa);
        }

        // ====================================================
        // 4. POST: /Admin/XoaSanPham (Xóa - Đã Sửa Route)
        // ====================================================
        [HttpPost]
        [Route("XoaSanPham")] // Sửa Route thành dạng đơn giản: /Admin/XoaSanPham
        public JsonResult XoaSanPham(string id)
        {
            try
            {
                HOA hoa = db.HOAs.Find(id);
                if (hoa == null) return Json(new { success = false, message = "Không tìm thấy sản phẩm." });

                // Kiểm tra ràng buộc
                bool isInOrder = db.CHITIET_DONHANG.Any(ct => ct.MaHoa == id);
                if (isInOrder)
                {
                    return Json(new { success = false, message = "Không thể xóa hoa này vì nó đã có trong đơn hàng." });
                }

                db.HOAs.Remove(hoa);
                db.SaveChanges();
                return Json(new { success = true, message = "Xóa sản phẩm thành công!" });
            }
            catch (Exception ex)
            {
                // Trả về lỗi chi tiết hơn
                return Json(new { success = false, message = "Lỗi hệ thống khi xóa: " + ex.InnerException?.InnerException?.Message ?? ex.Message });
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) db.Dispose();
            base.Dispose(disposing);
        }

        // ====================================================
        // 5. GET: /Admin/QLKho (Quản lý Tồn Kho)
        // ====================================================
        [Route("QLKho")]
        public ActionResult QLKho()
        {
            ViewBag.Title = "Quản lý Tồn Kho";

            // Lấy danh sách HOA, bao gồm cả LOAIHOA, sắp xếp theo tên
            var listHoa = db.HOAs.Include(h => h.LOAIHOA)
                                 .OrderBy(h => h.TenHoa)
                                 .ToList();

            return View(listHoa);
        }

        // ====================================================
        // 6. POST: /Admin/CapNhatKho (Nhập/Xuất Kho)
        // Action này sẽ xử lý việc cập nhật số lượng tồn kho
        // ====================================================
        [HttpPost]
        [Route("CapNhatKho")]
        public JsonResult CapNhatKho(string maHoa, int soLuongThem)
        {
            // soLuongThem: > 0 là Nhập kho, < 0 là Xuất kho (bán hàng)
            try
            {
                HOA hoa = db.HOAs.Find(maHoa);
                if (hoa == null)
                {
                    return Json(new { success = false, message = "Không tìm thấy mã hoa." });
                }

                // Kiểm tra số lượng tồn sau khi cập nhật
                if (hoa.SoLuongTon + soLuongThem < 0)
                {
                    return Json(new { success = false, message = "Lỗi: Số lượng tồn kho không đủ để xuất." });
                }

                // Cập nhật số lượng
                hoa.SoLuongTon += soLuongThem;

                // Cập nhật trạng thái (nếu cần)
                hoa.TrangThai = hoa.SoLuongTon > 0 ? "Còn hàng" : "Hết hàng";

                db.Entry(hoa).State = EntityState.Modified;
                db.SaveChanges();

                string actionType = soLuongThem > 0 ? "Nhập kho" : "Xuất kho";
                string message = $"{actionType} thành công! Tồn mới: {hoa.SoLuongTon}";

                // Trả về số lượng tồn mới để cập nhật trên View
                return Json(new { success = true, message = message, newQuantity = hoa.SoLuongTon });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Lỗi hệ thống khi cập nhật kho: " + ex.Message });
            }
        }

        [Route("QLKH")]
        public ActionResult QuanLyKhachHang()
        {
            ViewBag.Title = "Quản lý Khách hàng";

            // Lấy danh sách Khách hàng. Giả định model Khách hàng là KHACHHANG
            var listKhachHang = db.KHACHHANGs.OrderBy(kh => kh.HoTen).ToList();

            return View(listKhachHang);
        }
        // ====================================================
        // 8. GET: /Admin/ChiTietDonHangKH/{maKH} (Chi tiết Đơn hàng của KH)
        // ====================================================
        [Route("ChiTietDonHangKH/{maKH}")]
        public ActionResult ChiTietDonHangKH(string maKH)
        {
            if (maKH == null)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            }

            // 1. Lấy thông tin Khách hàng
            var khachHang = db.KHACHHANGs.Find(maKH);
            if (khachHang == null)
            {
                return HttpNotFound("Không tìm thấy Khách hàng.");
            }

            // 2. Lấy tất cả Đơn hàng của Khách hàng đó
            // Giả định model Đơn hàng là DONDATHANG và có khóa ngoại MaKH
            var listDonHang = db.GIOHANGs
                                .Where(dh => dh.MaKH == maKH)
                                .OrderByDescending(dh => dh.NgayTao)
                                .ToList();

            ViewBag.Title = $"Đơn hàng của: {khachHang.HoTen}";
            ViewBag.TenKH = khachHang.HoTen;
            ViewBag.MaKH = maKH;

            return View(listDonHang);
        }
    }
}