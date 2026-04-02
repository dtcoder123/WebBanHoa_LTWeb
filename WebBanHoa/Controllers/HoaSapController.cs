using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHoa.Models;

namespace WebBanHoa.Controllers
{
    public class HoaSapController : Controller
    {
        // GET: HoaSap
        public EFFirstDatabaseEntities db = new EFFirstDatabaseEntities();
        public ActionResult Index(string sort, string IconClass)
        {
            List<HOA> H = db.HOAs.Where(r => r.MaLoai == "L008").ToList();
            switch (sort)
            {
                case "MoTa":
                    // Xử lý sắp xếp Tên A-Z (Nếu bạn dùng thêm tham số IconClass để đảo ngược)
                    // Ví dụ: H = H.OrderBy(h => h.MoTa).ToList();
                    if (IconClass == "fa-sort-asc")
                    {
                        H = H.OrderBy(r => r.MoTa).ToList();
                    }
                    else
                    {
                        H = H.OrderByDescending(r => r.MoTa).ToList();
                    }
                    break;
                case "Gia":
                    // Xử lý sắp xếp Giá
                    // Ví dụ: H = H.OrderBy(h => h.Gia).ToList();
                    if (IconClass == "fa-sort-asc")
                    {
                        H = H.OrderBy(r => r.Gia).ToList();
                    }
                    else
                    {
                        H = H.OrderByDescending(r => r.Gia).ToList();
                    }
                    break;
                default:
                    // Case mặc định (Khi sort là NULL hoặc không khớp bất kỳ trường hợp nào)
                    // Sắp xếp theo MaHoa (ID) hoặc một trường Ngày/ID nào đó
                    H = db.HOAs.Where(r => r.MaLoai == "L008").ToList();
                    // Hoặc đơn giản là không cần .OrderBy() nếu bạn muốn giữ thứ tự DB ban đầu:
                    // H = db.HOAs.Where(r => r.MaLoai == "L008").ToList();
                    break;
            }
            ViewBag.Sort = sort;
            ViewBag.IconClass = IconClass;
            return View(H);
        }
    }
}