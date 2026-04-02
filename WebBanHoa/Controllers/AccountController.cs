using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHoa.App_Start;
using WebBanHoa.Models;

namespace WebBanHoa.Controllers
{
    public class AccountController : Controller
    {
        //
        // GET: /Account/
        public EFFirstDatabaseEntities db = new EFFirstDatabaseEntities();
        public ActionResult Index()
        {

            return View();
        }
        public ActionResult Register()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string email, string password)
        {
            // B1: Xác thực người dùng (Tìm trong CSDL)
            var user = db.TAIKHOANs
                        .FirstOrDefault(u => u.Email == email && u.Matkhau == password);
            // Thay TaiKhoan bằng tên bảng người dùng của bạn

            if (user != null)
            {
                // B2: Thiết lập Session (Lưu trạng thái đăng nhập)
                Session["UserID"] = user.Email;
                Session["UserRole"] = user.quyen; // Giả sử bạn có trường Role (Admin/User)
                var khachHang = db.KHACHHANGs.FirstOrDefault(kh => kh.Email == user.Email);
                if (khachHang != null)
                {
                    // LƯU MAKH VÀO SESSION KEY MÀ CARTCONTROLLER ĐANG CẦN
                    Session["MaKH"] = khachHang.MaKH;
                }
                // B3: PHÂN QUYỀN VÀ CHUYỂN HƯỚNG
                if (Session.IsAdmin()) // Tùy thuộc vào tên Role của bạn
                {
                    // Chuyển hướng Admin về trang quản trị
                    return RedirectToAction("Trangchu", "Admin"); // Chuyển đến Action Index trong AdminController
                }
                else
                {
                    // Chuyển hướng User thường về trang chủ hoặc trang cá nhân
                    return RedirectToAction("Index", "Home"); // Chuyển đến trang chủ
                }
            }
            else
            {
                // Đăng nhập thất bại
                ViewBag.Error = "Email hoặc mật khẩu không đúng.";
                return View(); // Trả về lại View Login
            }
        }
        public ActionResult Logout()
        {
            Session.Clear();
            Session.Abandon();
            return RedirectToAction("Login", "Account");
        }
    }
}