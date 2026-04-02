
CREATE TABLE KHACHHANG (
    MaKH VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    SoDienThoai NVARCHAR(20),
    DiaChi NVARCHAR(255),
    NgayDangKy DATE DEFAULT GETDATE()
);

CREATE TABLE LOAIHOA (
    MaLoai VARCHAR(10) PRIMARY KEY,
    TenLoai NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(255)
);

CREATE TABLE HOA (
    MaHoa VARCHAR(10) PRIMARY KEY,
    TenHoa NVARCHAR(200) NOT NULL,
    MaLoai VARCHAR(10) REFERENCES LOAIHOA(MaLoai),
    Gia DECIMAL(18,2) NOT NULL,
    SoLuongTon INT DEFAULT 0,
    MoTa NVARCHAR(500),
    HinhAnh NVARCHAR(255),
    TrangThai NVARCHAR(50) DEFAULT N'Còn hàng'
);

CREATE TABLE GIOHANG (
    MaGH VARCHAR(10) PRIMARY KEY,
    MaKH VARCHAR(10) REFERENCES KHACHHANG(MaKH),
    NgayTao DATETIME DEFAULT GETDATE()
);

CREATE TABLE CHITIET_GIOHANG (
    MaGH VARCHAR(10) REFERENCES GIOHANG(MaGH),
    MaHoa VARCHAR(10) REFERENCES HOA(MaHoa),
    SoLuong INT CHECK (SoLuong > 0),
    PRIMARY KEY (MaGH, MaHoa)
);

CREATE TABLE DONHANG (
    MaDH VARCHAR(10) PRIMARY KEY,
    MaKH VARCHAR(10) REFERENCES KHACHHANG(MaKH),
    NgayDat DATETIME DEFAULT GETDATE(),
    TongTien DECIMAL(18,2),
    DiaChiGiao NVARCHAR(255),
    TrangThai NVARCHAR(50) DEFAULT N'Chờ xử lý' -- Chờ xử lý, Đang giao, Đã giao, Hủy
);


CREATE TABLE CHITIET_DONHANG (
    MaDH VARCHAR(10) REFERENCES DONHANG(MaDH),
    MaHoa VARCHAR(10) REFERENCES HOA(MaHoa),
    SoLuong INT CHECK (SoLuong > 0),
    DonGia DECIMAL(18,2),
    PRIMARY KEY (MaDH, MaHoa)
);

CREATE TABLE NHANVIEN (
    MaNV VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100),
    Email NVARCHAR(255) UNIQUE,
    ChucVu NVARCHAR(50),
    Luong DECIMAL(18,2),
    NgayVaoLam DATE
);

CREATE TABLE KHUYENMAI (
    MaKM VARCHAR(10) PRIMARY KEY,
    TenKM NVARCHAR(100),
    PhanTramGiam INT CHECK (PhanTramGiam BETWEEN 0 AND 100),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    DieuKien NVARCHAR(255)
);

CREATE TABLE DONHANG_KHUYENMAI (
    MaDH VARCHAR(10) REFERENCES DONHANG(MaDH),
    MaKM VARCHAR(10) REFERENCES KHUYENMAI(MaKM),
    PRIMARY KEY (MaDH, MaKM)
);

INSERT INTO LOAIHOA (MaLoai, TenLoai, MoTa) VALUES
('L001', N'Hoa Hồng', N'Hoa hồng tượng trưng cho tình yêu, niềm đam mê và sự ngọt ngào trong cảm xúc.'),
('L002', N'Hoa Ly', N'Hoa ly mang vẻ đẹp sang trọng, tinh khiết, thường được tặng trong các dịp lễ trọng đại.'),
('L003', N'Hoa Lan', N'Hoa lan – loài hoa quý phái, biểu tượng của sự giàu sang và bền bỉ trong tình cảm.'),
('L004', N'Hoa Tulip', N'Hoa tulip mang hơi thở châu Âu, thể hiện sự thanh lịch, tinh tế và tươi mới.'),
('L005', N'Hoa Baby', N'Hoa baby (baby breath) tượng trưng cho sự trong sáng, nhẹ nhàng và tình yêu thuần khiết.'),
('L006', N'Hoa Cúc', N'Hoa cúc biểu trưng cho sự giản dị, trung thực và niềm hạnh phúc bền lâu.');

-- 🌼 BẢNG HOA (18 sản phẩm)
INSERT INTO HOA (MaHoa, TenHoa, MaLoai, Gia, SoLuongTon, MoTa, HinhAnh, TrangThai) VALUES

-- 🌹 HOA HỒNG
('H001', N'Bouquet Hồng Đỏ 12 Bông', 'L001', 600000, 25,
 N'Bó hoa gồm 12 bông hồng đỏ tươi, được gói trong lớp giấy kraft nâu sang trọng, thắt nơ đỏ rực. '
 + N'Hoa hồng đỏ tượng trưng cho tình yêu mãnh liệt và niềm đam mê bất tận – món quà lý tưởng cho người yêu trong dịp Valentine.',
 'https://mrhoa.com/wp-content/uploads/2022/05/bo-hoa-hong-do-12-bong-min-600x800.jpg', N'Còn hàng'),

('H002', N'Bouquet Hồng Trắng 8 Bông', 'L001', 550000, 18,
 N'Hoa hồng trắng tinh khôi được phối cùng hoa baby nhẹ, tạo nên vẻ đẹp thuần khiết và thanh lịch. '
 + N'Phù hợp tặng sinh nhật, kỷ niệm hoặc chúc mừng lễ tốt nghiệp.',
 'https://litiflorist.com/upload/1614323573876.png', N'Còn hàng'),

('H003', N'Bouquet Hồng Phấn 10 Bông', 'L001', 580000, 22,
 N'Hoa hồng phấn mang sắc hồng nhẹ nhàng, được bó tròn tinh tế với lớp giấy lụa hồng pastel. '
 + N'Tượng trưng cho tình yêu ngọt ngào, sự khởi đầu trong sáng – rất hợp để tặng bạn gái mới quen 💕.',
 'https://tse4.mm.bing.net/th/id/OIP.9NKTf-uRSmWHcnQ2mQi2RgHaHm?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng'),

-- 🌺 HOA LY
('H004', N'Bouquet Ly Trắng 5 Bông', 'L002', 450000, 20,
 N'5 bông hoa ly trắng tinh khôi, tỏa hương dịu nhẹ. '
 + N'Hoa được cắm xen kẽ lá xanh, mang lại vẻ đẹp trang nhã, thích hợp cho dịp tặng sinh nhật hoặc lễ tốt nghiệp.',
 'https://www.whiteflowerfarm.com/mas_assets/cache/image/5/3/2/f/21295.Jpg', N'Còn hàng'),

('H005', N'Bouquet Ly Hồng 7 Bông', 'L002', 480000, 17,
 N'Hoa ly hồng mang vẻ đẹp nữ tính và kiêu sa, tượng trưng cho lòng biết ơn và sự ngưỡng mộ. '
 + N'Thích hợp làm quà tặng mẹ, cô giáo hoặc người phụ nữ bạn yêu quý 🌸.',
 'https://tse4.mm.bing.net/th/id/OIP.vU6aAFHGp5AMVRVH03NSWwHaJ3?cb=ucfimg2ucfimg=1&w=736&h=981&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng'),

('H006', N'Bouquet Ly Vàng 9 Bông', 'L002', 500000, 15,
 N'Hoa ly vàng nổi bật với sắc màu rực rỡ, tươi sáng, tượng trưng cho sự thành công và thịnh vượng. '
 + N'Lý tưởng để tặng đối tác, chúc mừng khai trương hoặc dịp kỷ niệm công việc.',
 'https://flowersight.com/wp-content/uploads/2024/08/bo-hoa-ly-vang.jpg', N'Còn hàng'),

-- 🌸 HOA LAN
('H007', N'Giỏ Lan Hồ Điệp Trắng', 'L003', 700000, 10,
 N'Giỏ hoa lan hồ điệp trắng tinh khôi được trang trí bằng chậu sứ sang trọng. '
 + N'Hoa lan biểu trưng cho vẻ đẹp bền lâu, thanh tao – thích hợp trang trí phòng khách hoặc làm quà tặng cao cấp.',
 'https://th.bing.com/th/id/R.f02f159578b745894e2ffc691ba0ad3b?rik=DVoHNfbOFTjiFQ&pid=ImgRaw&r=0', N'Còn hàng'),

('H008', N'Giỏ Lan Hồ Điệp Tím', 'L003', 720000, 8,
 N'Hoa lan hồ điệp tím rực rỡ, nổi bật giữa nền lá xanh mướt. '
 + N'Lan tím thể hiện sự quý phái, lòng ngưỡng mộ và tình yêu thủy chung.',
 'https://tse3.mm.bing.net/th/id/OIP.uu2ZWgfWklLZVvbDZPnJPgHaJ4?cb=ucfimg2ucfimg=1&w=2250&h=3000&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng'),

('H009', N'Lan Hồ Điệp Vàng 4 Cành', 'L003', 750000, 6,
 N'4 cành hoa lan vàng tươi rực rỡ, cắm trong chậu sứ trắng tinh tế. '
 + N'Lan vàng tượng trưng cho sự may mắn, phú quý – rất hợp làm quà biếu doanh nghiệp hoặc dịp lễ Tết.',
 'https://th.bing.com/th/id/R.a430bae64e8e0caad1e28da5c25a85dd?rik=fx6ghJsML1G1Yg&pid=ImgRaw&r=0', N'Còn hàng'),

-- 🌷 HOA TULIP
('H010', N'Bouquet Tulip Đa Màu 10 Bông', 'L004', 520000, 30,
 N'10 bông tulip với các sắc đỏ, vàng, cam, hồng được phối hợp hài hòa, tạo cảm giác tươi vui và năng động. '
 + N'Hoa tulip đa sắc là lựa chọn hoàn hảo cho những ai yêu phong cách hiện đại và trẻ trung.',
 'https://flowersight.com/wp-content/uploads/2024/07/bo-hoa-tulip-10-bong-2.jpg', N'Còn hàng'),

('H011', N'Bouquet Tulip Hồng 8 Bông', 'L004', 500000, 28,
 N'Hoa tulip hồng nhẹ nhàng, cắm xen hoa baby trắng tạo vẻ đẹp ngọt ngào. '
 + N'Rất phù hợp tặng người yêu hoặc bạn thân trong dịp sinh nhật, kỷ niệm.',
 'https://tse3.mm.bing.net/th/id/OIP.esnUEWnSyom2iz1VXQicoQHaHa?cb=ucfimg2ucfimg=1&w=800&h=800&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng'),

('H012', N'Bouquet Tulip Trắng 6 Bông', 'L004', 480000, 32,
 N'Hoa tulip trắng tinh khôi, gói trong giấy nâu mộc mạc. '
 + N'Mang thông điệp về sự chân thành và tôn trọng – thích hợp tặng đối tác hoặc dịp lễ trọng đại.',
 'https://tse1.mm.bing.net/th/id/OIP.KuhSqWDoUrwrAEzTW8c6CAHaHa?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng'),

-- 💐 HOA BABY
('H013', N'Bouquet Baby Breath Trắng', 'L005', 380000, 40,
 N'Hoa baby trắng nhẹ nhàng, được bó tròn, gói bằng giấy lụa xanh nhạt. '
 + N'Tượng trưng cho sự thuần khiết và tình yêu trong sáng – món quà “cute” mà ai cũng thích 🥰.',
 'https://tse4.mm.bing.net/th/id/OIP.fOYqCJd52X0lVjfLKCfMtQHaHa?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng'),

('H014', N'Bouquet Baby Breath Hồng', 'L005', 390000, 35,
 N'Hoa baby hồng pastel mềm mại, tạo cảm giác mộng mơ, nhẹ nhàng. '
 + N'Phù hợp tặng bạn gái, hoặc trang trí bàn tiệc sinh nhật cực xinh luôn 💕.',
 'https://tse4.mm.bing.net/th/id/OIP.60cE9O1YS49pGSZpKHJ0MwHaHa?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng'),

('H015', N'Bouquet Baby Breath Xanh', 'L005', 400000, 33,
 N'Hoa baby màu xanh mint mát mắt, bó tròn hiện đại. '
 + N'Thường được chọn làm hoa phụ cho cô dâu hoặc tặng bạn thân trong dịp tốt nghiệp.',
 'https://tse4.mm.bing.net/th/id/OIP.7Z4XiKeUqhZP0vuomRLyTQHaHa?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng'),

-- 🌻 HOA CÚC
('H016', N'Bouquet Cúc Vàng 10 Bông', 'L006', 320000, 50,
 N'Hoa cúc vàng rực rỡ, biểu trưng cho niềm vui và năng lượng tích cực. '
 + N'Bó hoa cắm xen lá xanh, tạo cảm giác tươi mới – phù hợp tặng dịp Tết hoặc chúc mừng khai trương.',
 'https://storage.googleapis.com/cdn_dlhf_vn/public/products/CBHO/CBHOATET015/DSC_0240-Editc.jpg', N'Còn hàng'),

('H017', N'Bouquet Cúc Hồng 8 Bông', 'L006', 340000, 45,
 N'Hoa cúc hồng mang sắc dịu dàng, tượng trưng cho tình bạn và sự quan tâm. '
 + N'Là món quà lý tưởng tặng người thân trong gia đình hoặc bạn bè thân thiết.',
 'https://i.pinimg.com/originals/b6/03/8e/b6038ed267981438b97ca61a93e03cb7.jpg', N'Còn hàng'),

('H018', N'Bouquet Cúc Trắng 6 Bông', 'L006', 300000, 55,
 N'Hoa cúc trắng thanh khiết, gói trong giấy kraft vintage. '
 + N'Tượng trưng cho lòng chân thành và sự tinh tế – thích hợp tặng trong dịp tưởng nhớ hoặc tri ân.',
 'https://tse2.mm.bing.net/th/id/OIP.r95r_HHweOkf9Gc8PpFNtgHaHa?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng');

 INSERT INTO NHANVIEN (MaNV, HoTen, Email, ChucVu, Luong, NgayVaoLam)
VALUES
('NV001', N'Nguyễn Thị Hoa', 'hoa.nguyen@hoashop.vn', N'Quản lý', 18000000, '2022-01-15'),
('NV002', N'Lê Văn Phúc', 'phuc.le@hoashop.vn', N'Nhân viên bán hàng', 12000000, '2023-03-10'),
('NV003', N'Trần Ngọc Lan', 'lan.tran@hoashop.vn', N'Thủ kho', 11000000, '2023-05-22'),
('NV004', N'Phạm Minh Huy', 'huy.pham@hoashop.vn', N'Nhân viên giao hàng', 9000000, '2024-01-05'),
('NV005', N'Vũ Thị Mai', 'mai.vu@hoashop.vn', N'Nhân viên tư vấn online', 9500000, '2023-07-12'),
('NV006', N'Đặng Hoàng Long', 'long.dang@hoashop.vn', N'Nhân viên kế toán', 13000000, '2022-11-25'),
('NV007', N'Lý Thanh Tâm', 'tam.ly@hoashop.vn', N'Nhân viên chăm sóc khách hàng', 10000000, '2024-04-01'),
('NV008', N'Ngô Bảo Anh', 'anh.ngo@hoashop.vn', N'Nhân viên marketing', 12500000, '2023-09-18'),
('NV009', N'Tạ Đức Kiên', 'kien.ta@hoashop.vn', N'Nhân viên kỹ thuật website', 15000000, '2022-08-09'),
('NV010', N'Phan Mỹ Duyên', 'duyen.phan@hoashop.vn', N'Nhân viên bán hàng', 12000000, '2023-10-20');

INSERT INTO KHUYENMAI (MaKM, TenKM, PhanTramGiam, NgayBatDau, NgayKetThuc, DieuKien)
VALUES
('KM001', N'Khuyến mãi Valentine', 20, '2025-02-10', '2025-02-15', N'Áp dụng cho đơn hàng từ 500,000đ trở lên'),
('KM002', N'Ngày Phụ Nữ Việt Nam 20/10', 25, '2025-10-15', '2025-10-21', N'Áp dụng cho hoa hồng và hoa tulip'),
('KM003', N'Black Friday', 30, '2025-11-25', '2025-11-30', N'Áp dụng toàn bộ sản phẩm'),
('KM004', N'Giáng Sinh An Lành', 15, '2025-12-20', '2025-12-26', N'Áp dụng cho hoa lan và hoa baby'),
('KM005', N'Tết Nguyên Đán Rực Rỡ', 20, '2026-01-20', '2026-02-05', N'Áp dụng cho đơn hàng trên 700,000đ'),
('KM006', N'Khách hàng thân thiết', 10, '2025-01-01', '2025-12-31', N'Áp dụng cho khách hàng đã mua trên 5 đơn hàng'),
('KM007', N'Sinh nhật khách hàng', 15, '2025-01-01', '2025-12-31', N'Áp dụng trong tháng sinh nhật của khách hàng'),
('KM008', N'Khuyến mãi mùa hè', 12, '2025-06-01', '2025-06-30', N'Áp dụng cho hoa cúc và hoa ly'),
('KM009', N'Ngày Quốc tế Phụ nữ 8/3', 25, '2025-03-01', '2025-03-08', N'Áp dụng cho tất cả sản phẩm dành cho nữ'),
('KM010', N'Mừng khai trương chi nhánh mới', 18, '2025-09-01', '2025-09-10', N'Áp dụng cho khách mua tại chi nhánh TP.HCM');

INSERT INTO KHACHHANG (MaKH, HoTen, Email, SoDienThoai, DiaChi, NgayDangKy)
VALUES
('KH001', N'Nguyễn Minh Anh', 'minhanh.nguyen@example.com', '0905123456', N'123 Lê Lợi, Quận 1, TP.HCM', '2024-05-12'),
('KH002', N'Trần Bảo Ngọc', 'baongoc.tran@example.com', '0912345678', N'45 Nguyễn Huệ, Quận Hải Châu, Đà Nẵng', '2024-08-20'),
('KH003', N'Lê Quốc Huy', 'quochuy.le@example.com', '0987654321', N'89 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2025-02-10');