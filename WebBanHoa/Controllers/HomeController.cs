using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHoa.Models;
namespace WebBanHoa.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        EFFirstDatabaseEntities db = new EFFirstDatabaseEntities();
        public ActionResult Index()
        {
            List<string> featuredFlowerIds = new List<string> {"H001", "H007", "H010", "H004", "H013", "H016"};
            List<HOA> featuredFlowers = db.HOAs.Where(h => featuredFlowerIds.Contains(h.MaHoa)).ToList();
            return View(featuredFlowers);
        }
        [Route("Flower/Details/{id}")]
        public ActionResult DetailHome(string id)
        {
            if (string.IsNullOrEmpty(id))
                return HttpNotFound();
            var Hoa = db.HOAs.FirstOrDefault(p => p.MaHoa == id);
            if (Hoa == null)
                return HttpNotFound();
            return View(Hoa);
        }
        [HttpGet]
        public ActionResult Search(string query)
        {
            // 1. Kiểm tra từ khóa tìm kiếm
            if (string.IsNullOrWhiteSpace(query))
            {
                // Nếu không có từ khóa, trả về View với danh sách rỗng
                ViewBag.SearchQuery = "";
                return View("Search", new List<HOA>());
            }

            // 2. Chuyển đổi từ khóa sang chữ thường và loại bỏ khoảng trắng dư thừa
            string searchQuery = query.Trim().ToLower();

            // 3. Truy vấn cơ sở dữ liệu
            // Tìm kiếm các sản phẩm HOA có Tên Hoa (TenHoa) hoặc Mô tả (MoTa) chứa từ khóa
            var searchResults = db.HOAs
                .Where(h => h.TenHoa.ToLower().Contains(searchQuery) ||
                            (h.MoTa != null && h.MoTa.ToLower().Contains(searchQuery)))
                .ToList();

            // 4. Truyền thông tin và kết quả sang View
            ViewBag.SearchQuery = query;
            ViewBag.ResultCount = searchResults.Count; // Số lượng kết quả

            return View("Search", searchResults); // Trả về View "Search" với danh sách kết quả
        }
        [Route("Home/LienHe")]
        public ActionResult LienHe()
        {
            return View();
        }
    }
}