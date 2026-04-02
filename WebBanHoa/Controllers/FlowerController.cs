using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanHoa.Models;

namespace WebBanHoa.Controllers
{
    public class FlowerController : Controller
    {
        public EFFirstDatabaseEntities db = new EFFirstDatabaseEntities();
        // 1. Lấy dữ liệu cơ sở (Filter theo MaLoai)
        public ActionResult Index(string MaLoai, string sort, int page = 1)
        {
            IQueryable<HOA> listHoa = db.HOAs.AsQueryable();

            if (!string.IsNullOrEmpty(MaLoai))
            {
                listHoa = listHoa.Where(h => h.MaLoai == MaLoai);
            }

            // 2. Xử lý Logic Sắp xếp (QUAN TRỌNG: Đây là phần bạn cần kiểm tra)
            switch (sort)
            {
                case "price_asc":
                    listHoa = listHoa.OrderBy(h => h.Gia);
                    break;
                case "price_desc":
                    listHoa = listHoa.OrderByDescending(h => h.Gia);
                    break;
                case "stock_desc":
                    listHoa = listHoa.OrderByDescending(h => h.SoLuongTon);
                    break;
                case "default": // Mặc định
                default:
                    listHoa = listHoa.OrderBy(h => h.TenHoa).ThenBy(h => h.MaHoa); // Sắp xếp mặc định theo Tên hoặc Mã
                    break;
            }

            // 3. Xử lý Phân trang (Paging)
            int pageSize = 9; // Giả sử 9 sản phẩm/trang
            int totalItems = listHoa.Count();
            int totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

            // Đảm bảo trang hiện tại hợp lệ
            page = Math.Max(1, Math.Min(page, totalPages > 0 ? totalPages : 1));

            var model = listHoa.Skip((page - 1) * pageSize).Take(pageSize).ToList();

            // 4. Truyền thông tin phân trang/filter/sort về View qua ViewBag
            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = totalPages;
            ViewBag.MaLoai = MaLoai;
            ViewBag.Sort = sort;
            ViewBag.TotalItems = totalItems;

            return View(model);
        }
        [Route("Flower/Details/{id}")]
        public ActionResult DetailFlower(string id)
        {
            if (string.IsNullOrEmpty(id))
                return HttpNotFound();
            var Hoa = db.HOAs.FirstOrDefault(p => p.MaHoa == id);
            if (Hoa == null)
                return HttpNotFound();
            return View(Hoa);
        }
    }
}