using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using WebBanHoa.Models;

namespace WebBanHoa.Controllers
{
    public class KeHoaChucMungController : Controller
    {
        // GET: KeHoaChucMung
        public EFFirstDatabaseEntities db = new EFFirstDatabaseEntities();
        public ActionResult Index(string sort, string IconClass, int page = 1)
        {
            List<HOA> H = db.HOAs.Where(r => r.MaLoai == "L009").OrderBy(h => h.MaHoa).ToList();
            switch (sort)
            {
                case "TenHoa":
                    if (IconClass == "fa-sort-asc")
                    {
                        H = H.OrderBy(r => r.TenHoa).ToList();
                    }
                    else
                    {
                        H = H.OrderByDescending(r => r.TenHoa).ToList();
                    }
                    break;
                case "Gia":
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
                    H = H.OrderBy(h =>
                int.Parse(Regex.Replace(h.MaHoa, "[^0-9]", ""))
            ).ToList();
                    break;
            }
            ViewBag.Sort = sort;
            ViewBag.IconClass = IconClass;
            int NoOfRecordPage = 16;
            int NoOfPages = Convert.ToInt32(Math.Ceiling(Convert.ToDouble(H.Count) / Convert.ToDouble(NoOfRecordPage)));
            int NoOfRecordToSkip = (page - 1) * NoOfRecordPage;
            ViewBag.Page = page;
            ViewBag.NoOfPages = NoOfPages;
            H = H.Skip(NoOfRecordToSkip).Take(NoOfRecordPage).ToList();
            return View(H);
        }
    }
}