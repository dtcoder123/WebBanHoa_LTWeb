using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebBanHoa.ViewModel
{
    public class Chitietgiohang
    {
        public string MaHoa { get; set; }

        public string TenHoa { get; set; } // Từ bảng HOA
        public decimal Gia { get; set; } // Từ bảng HOA
        public int SoLuong { get; set; } // Từ bảng CHITIET_GIOHANG
        public string HinhAnh { get; set; } // Từ bảng HOA
        public decimal ThanhTien { get { return Gia * SoLuong; } }
    }
    public class GioHang
    {
        public string MaGH { get; set; }
        public List<Chitietgiohang> DanhSachSanPham { get; set; }
        public decimal TongTien { get; set; } // Tổng cộng tất cả sản phẩm
    }

}