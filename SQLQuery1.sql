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
CREATE TABLE TAIKHOAN(
	TenDangNhap Nvarchar(50) not null,
	MatKhau Nvarchar(20),
	quyen nvarchar(10) default 'user',
	Email Nvarchar(30),
)
Insert into TAIKHOAN(TenDangNhap,MatKhau,quyen,Email) Values
('Admin', '123456','Admin','Admin@gmail.com'),
('user1','1122','User','User@gmail.com');

INSERT INTO LOAIHOA (MaLoai, TenLoai, MoTa) VALUES
('L001', N'Hoa Hồng', N'Hoa hồng tượng trưng cho tình yêu, niềm đam mê và sự ngọt ngào trong cảm xúc.'),
('L002', N'Hoa Ly', N'Hoa ly mang vẻ đẹp sang trọng, tinh khiết, thường được tặng trong các dịp lễ trọng đại.'),
('L003', N'Hoa Lan', N'Hoa lan – loài hoa quý phái, biểu tượng của sự giàu sang và bền bỉ trong tình cảm.'),
('L004', N'Hoa Tulip', N'Hoa tulip mang hơi thở châu Âu, thể hiện sự thanh lịch, tinh tế và tươi mới.'),
('L005', N'Hoa Baby', N'Hoa baby (baby breath) tượng trưng cho sự trong sáng, nhẹ nhàng và tình yêu thuần khiết.'),
('L006', N'Hoa Cúc', N'Hoa cúc biểu trưng cho sự giản dị, trung thực và niềm hạnh phúc bền lâu.'),
('L007',N'Hoa Cưới',''),
('L008',N'Hoa Sáp',''),
('L009',N'Ke Hoa Chúc mừng',''),
('L0010',N'Gio Hoa Chúc Mừng',''),
('L0011',N'Bó Hoa Tươi','');


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
 'https://tse2.mm.bing.net/th/id/OIP.r95r_HHweOkf9Gc8PpFNtgHaHa?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3', N'Còn hàng'),

 ('H019', N'tulip trắng', 'L007', 1200000, 20,
 N'Hoa Cưới Tulip Trắng 10 Bông – Thanh Khiết & Tinh Tế ',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/dsc05989-1747886576924.jpg?v=1760432515657', N'Còn hàng'),

 ('H020', N'tulip', 'L007', 1500000, 34,
 N'Hoa cưới Tulip',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/0f4259b7-0ca8-4281-9dde-4fc2d0d9021a-df3108d7-dac6-44ad-a854-34b0815bd0be.jpg?v=1760432516377', N'Còn hàng'),

 ('H021', N'Hồng trắng mix phi yến', 'L007', 1000000, 27,
 N'Hoa cưới Hồng Trắng mix phi yến',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/60051864-4b91-41b3-a4f5-bfcc4336e869-172a385b-3c75-40cf-82cf-ae00160bb6c8.jpg?v=1760432514913', N'Còn hàng'),

 ('H022', N'Hồng trắng', 'L007', 1000000, 27,
 N'Hoa cưới Hồng Trắng',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/f22755b7-3dc1-4675-8628-08e077ea524b-db327258-936b-487a-9dbe-781257cb5208.jpg?v=1760432514973', N'Còn hàng'),

 ('H023', N'Cát tường mix hồng trắng', 'L007', 800000, 12,
 N'Hoa cưới cát tường mix hồng trắng',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/a51d8e91-e013-4774-b9f4-660b4f098e78-30dae6c3-08ea-4df3-a893-76140e0bafde.jpg?v=1760432527977', N'Còn hàng'),

 ('H024', N'Tulip SP000007', 'L007', 1500000, 22,
 N'Hoa cưới tulip SP000007',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/65f6c2a120134df2ace75655b6a4b7-1722653591040.jpg?v=1760432516803', N'Còn hàng'),

 ('H025', N'Hồng đỏ', 'L007', 800000, 45,
 N'Hoa cưới hồng đỏ SP000009',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/906f51f663204f91b3e9eb49162489-1722653593495.jpg?v=1760432528123', N'Còn hàng'),

 ('H026', N'SP000010', 'L007', 800000, 15,
 N'Hoa cưới tone hồng SP000010',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/6f746ecd-85e8-4f0d-b43e-1d3443e007eb-c06d2410-4654-4456-86f8-0fb221cc4e97.jpg?v=1760432528163', N'Còn hàng'),

 ('H027', N'Tulip mix cát tường', 'L007', 1500000, 17,
 N'Hoa cưới tulip mix cát tường',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/9eeedfe0-f320-4ade-b798-d6f8a6420cf3-87094deb-18d5-4900-a1b2-4c3a1cdfc4b5.jpg?v=1760432516857', N'Còn hàng'),

 ('H028', N'Cally mix cát tường', 'L007', 2000000, 27,
 N'Hoa cưới cally mix tulip SP000018',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/433091b3480b44fe9a14366dd4c80f-1722653618377.jpg?v=1760432519140', N'Còn hàng'),

 ('H029', N'Tulip SP000036', 'L007', 1100000, 20,
 N'Hoa cưới tulip SP000036',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/4ddb74ef20284b879bf639141e7bfe-1722653682470.jpg?v=1760432515490', N'Còn hàng'),

 ('H030', N'Hướng dương mix tana', 'L007', 600000, 30,
 N'Hoa cưới hướng dương mix tana',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/43c6ef7068f2467e9cc74c2dcb2eb8-1722653683116.jpg?v=1760432526320', N'Còn hàng'),

 ('H031', N'Sen đá', 'L007', 900000, 35,
 N'Hoa cưới sen đá SP000038',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/344e46dadb8545d5963bf538886c36-1722653684094.jpg?v=1760432528713', N'Còn hàng'),

 ('H032', N'Tulip trắng', 'L007', 1100000, 15,
 N'Hoa cưới tulip trắng SP000048',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/db26e8f53bfa400eb65f55de9e5095-1722654026836.jpg?v=1760432515550', N'Còn hàng'),

 ('H033', N'Hồng mix baby', 'L007', 800000, 25,
 N'Hoa cưới hồng mix baby SP000049',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/74ecbbb888e0459e8e2551098b6ffb-1722654027924.jpg?v=1760432528357', N'Còn hàng'),

 ('H034', N'Hồng mix baby', 'L007', 1000000, 35,
 N'Hoa cưới hồng mix baby SP000050',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/7151abfff0694cc58cf0b92ecda124-1722654028613.jpg?v=1760432515227', N'Còn hàng'),

 ('H035', N'Hồng mix baby', 'L007', 1000000, 35,
 N'Hoa cưới hồng mix baby SP000051',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/b12660cbd7c646cfa33b5aab8bd070-1722654029366.jpg?v=1760432515260', N'Còn hàng'),

 ('H036', N'Tulip mix cally hồng', 'L007', 1500000, 30,
 N'Hoa cưới tulip mix cally hồng SP000052',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/930b0ba7ba0e4314bad0ad58c624c0-1722654030131.jpg?v=1760432517003', N'Còn hàng'),

 ('H037', N'Tulip', 'L007', 1100000, 32,
 N'Hoa cưới tulip SP000053',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/0b50978f86714ad3854fc8f705a488-1722654031630.jpg?v=1760432515607', N'Còn hàng'),

 ('H038', N'Tulip mix cally', 'L007', 1500000, 22,
 N'Hoa cưới tulip mix cally SP000054',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/18daf2561f4e4786a69b02ea7acf90-1722654032459.jpg?v=1760432517050', N'Còn hàng'),

 ('H039', N'Hoa Hồng', 'L007', 800000, 22,
 N'Hoa hồng cưới',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/19d8af6a2b6f4a9c807a79d55ea42a-jpeg-1722654049746.jpg?v=1760432528413', N'Còn hàng'),

 ('H039', N'Hoa cưới khô', 'L007', 1500000, 38,
 N'Hoa cưới khô',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/9772fe5bff3e4eb9bc4d386eb4d140-jpeg-1722654054065.jpg?v=1760432517110', N'Còn hàng'),

 ('H040', N'Hoa Sáp Xanh Pastel', 'L008', 150000, 18,
 N'Bó Hoa Sáp Xanh Pastel – Độc Đáo & Tinh Tế Như Lời Nhắn “You Are Sunshine”',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/986fea1a-2be5-45be-8f94-094ff1ea5da8.jpg?v=1763090605300', N'Còn hàng'),

 ('H041', N'Hoa Sáp Xanh Pastel 20 Bông', 'L008', 350000, 28,
 N'Bó Hoa Sáp Xanh Pastel 20 Bông – Tươi Mát & Ấn Tượng Lâu Dài',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/31f7ec7a-e6f9-4699-acde-dd820b136b5b.jpg?v=1763090507320', N'Còn hàng'),

 ('H042', N'Hoa Sáp Xanh Pastel', 'L008', 400000, 20,
 N'Bó Hoa Sáp Xanh Pastel – Đẳng Cấp & Trường Tồn Như Tình Yêu Lâu Dài',
 'https://th.bing.com/th/id/OIP.LE2N1zjds1pBQZHJmebcvQHaHy?w=209&h=220&c=7&r=0&o=7&dpr=2&pid=1.7&rm=3', N'Còn hàng'),

 ('H043', N'Hoa Bi Khô Đỏ', 'L008', 450000, 22,
 N'Bó Hoa Bi Khô Đỏ – Cá Tính & Ấn Tượng Khó Phai',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/7d977015-f660-468e-aa92-6d1e55b2b6f6-8b98c7f4-cb5d-41a7-a080-a33a20c779d2.jpg?v=1760432523933', N'Còn hàng'),

 ('H044', N'Hoa Bi Khô Đỏ', 'L008', 300000, 31,
 N'Bó Hoa Sáp Hồng Đậm – “Every Love You” – Đậm Đà & Lâu Bền Như Tình Yêu',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/7d977015-f660-468e-aa92-6d1e55b2b6f6-8b98c7f4-cb5d-41a7-a080-a33a20c779d2.jpg?v=1760432523933', N'Còn hàng'),

 ('H045', N'Hoa Sáp Hồng Pastel', 'L008', 200000, 42,
 N'🌸 Bó Hoa Sáp Hồng Pastel – Dịu Dàng & Dễ Thương Như Ánh Mắt Người Thương',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/d08a4678-d17f-4282-b3ec-d49a89df7a6b-815ce74d-dafe-47f3-acdf-bcc347d4a3b8.jpg?v=1760432520947', N'Còn hàng'),

 ('H046', N'Giỏ Hoa Sáp Hồng - Xanh Dương', 'L008', 450000, 30,
 N'💼 Giỏ Hoa Sáp Hồng – Xanh Dương: Chúc Mừng Trọng Thị & Sang Trọng Lịch Lãm',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/bbd87433-2175-413f-bc06-9f9f0d69a1f4-0769bbe2-5681-4978-af04-54803a4cb567.jpg?v=1760432523980', N'Còn hàng'),

 ('H047', N'Hoa Sáp Xanh', 'L008', 300000, 25,
 N'Bó hoa sáp xanh 19 bông',
 '/Images/Hoa8.webp', N'Còn hàng'),

  ('H048', N'Hoa Sáp Hồng Nhạt', 'L008', 150000, 15,
 N'Bó hoa sáp hồng nhạt',
 '/Images/Hoa9.webp', N'Còn hàng'),

 ('H049', N'Hoa nhũ Xanh Ngọc', 'L008', 200000, 20,
 N'Bó hoa nhũ xanh ngọc',
 '/Images/Hoa10.webp', N'Còn hàng'),

 ('H050', N'Hoa Sáp Hoa Hồng', 'L008', 370000, 37,
 N'Bó hoa sáp hoa hồng',
 '/Images/Hoa11.webp', N'Còn hàng'),

 ('H051', N'Hoa Sáp mix màu hồng', 'L008', 370000, 37,
 N'Bó hoa sáp mix màu hồng',
 '/Images/Hoa12.webp', N'Còn hàng'),

 ('H052', N'Hoa Sáp mix màu', 'L008', 370000, 27,
 N'Bó hoa sáp mix màu',
 '/Images/Hoa13.webp', N'Còn hàng'),

 ('H053', N'Hoa gấu tặng', 'L008', 450000, 45,
 N'Bó hoa gấu tặng',
 '/Images/Hoa14.webp', N'Còn hàng'),

 ('H054', N'Hoa Sáp hồng', 'L008', 350000, 35,
 N'Bó hoa Hồng sáp bông SP000043',
 '/Images/Hoa15.webp', N'Còn hàng'),

 ('H055', N'Hoa Sáp hồng', 'L008', 300000, 30,
 N'Hoa Hồng sáp 19 bông',
 '/Images/Hoa16.webp', N'Còn hàng'),

 ('H056', N'Hoa Sáp hồng mix cúc mẫu đơn', 'L008', 570000, 37,
 N'Giỏ hoa hồng mix cúc mẫu đơn',
 '/Images/Hoa17.webp', N'Còn hàng'),

 ('H057', N'Hoa Sáp hồng 10 bông', 'L008', 250000, 25,
 N'Hoa Hồng sáp 10 bông SP000046',
 '/Images/Hoa18.webp', N'Còn hàng'),

 ('H058', N'Hoa Sáp hồng mix', 'L008', 600000, 25,
 N'Giỏ hoa hồng mix',
 '/Images/Hoa19.webp', N'Còn hàng'),

 ('H059', N'Hoa Sáp hồng', 'L008', 600000, 32,
 N'Hoa Hồng sáp công chúa SP000057',
 '/Images/Hoa20.webp', N'Còn hàng'),

 ('H060', N'Hoa Sáp công chúa', 'L008', 550000, 12,
 N'Hoa Hồng sáp công chúa',
 '/Images/Hoa21.webp', N'Còn hàng'),

 ('H061', N'Hoa Sáp', 'L008', 450000, 17,
 N'giỏ hoa sáp',
 '/Images/Hoa22.webp', N'Còn hàng'),

 ('H062', N'Hoa Sáp', 'L008', 270000, 0,
 N'bó hoa sáp',
 '/Images/Hoa23.webp', N'hết hàng'),

 ('H063', N'Hoa Sáp', 'L008', 450000, 10,
 N'hộp hoa sáp',
 '/Images/Hoa24.webp', N'hết hàng'),

 ('H064', N'Hoa Sáp', 'L008', 450000.00, 10, N'10 hộp hoa sáp', '/Images/Hoa24.webp', N'hết hàng'),

('H065', N'Hoa chúc mừng hoa khai trương SP000088', 'L009', 1900000.00, 20, N'Hoa chúc mừng hoa khai trương SP000088', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/cf33d4c167e446b5a82fe3d04c8a5a-jpeg-1722654062107.jpg?v=1760432518023', N'còn hàng'),

('H066', 'Hoa khai trương, hoa chúc mừng SP000089', 'L009', 4800000.00, 22, 'Hoa khai trương, hoa chúc mừng SP000089', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/0a7ac645921d40c5a6a674e61dd2ef-jpeg-1722654063714.jpg?v=1760432523010', 'còn hàng'),
('H067', 'Kệ hoa khai trương, chúc mừng mini SP000090', 'L009', 1100000.00, 11, 'Kệ hoa khai trương, chúc mừng mini SP000090', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/67a23085-1433-4b6a-a9e5-f0d6bd5f8b14-a8c555c8-e08f-411d-9dfc-bab66522fe10.jpg?v=1760432515437', 'còn hàng'),
('H068', 'Kệ hoa Khai Trương/Chúc Mừng mini SP000091', 'L009', 1100000.00, 11, 'Kệ hoa Khai Trương/Chúc Mừng mini SP000091', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/9f919d1b-c620-44eb-8a81-9ede8e0ece25-d158250d-fb63-4621-9dfa-3f935779ad36.jpg?v=1760432515380', 'còn hàng'),
('H069', 'Kệ hoa khai trương/chúc mừng SP000092', 'L009', 1700000.00, 21, 'Kệ hoa khai trương/chúc mừng sp000092', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1000-1722653579384.jpg?v=1760432516747', 'còn hàng'),
('H070', 'Kệ hoa khai trương/chúc mừng SP000094', 'L009', 1700000.00, 21, 'Kệ hoa khai trương/chúc mừng SP000094', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1300-1722653574887.jpg?v=1760432516697', 'còn hàng'),
('H071', 'Kệ hoa khai trương/chúc mừng SP000096', 'L009', 1500000.00, 21, 'Kệ hoa khai trương/chúc mừng sp000096', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1400-1722653573146.jpg?v=1760432516653', 'còn hàng'),
('H072', 'Kệ hoa khai trương/chúc mừng SP000102', 'L009', 2300000.00, 21, 'Kệ hoa khai trương/chúc mừng SP000102', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1800-2-1722653563019.jpg?v=1760432519593', 'còn hàng'),
('H073', 'Kệ hoa khai trương/chúc mừng SP000106', 'L009', 2000000.00, 21, 'Kệ hoa khai trương/chúc mừng SP000106', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1800-1722653849972.jpg?v=1760432518923', 'còn hàng'),
('H074', 'Kệ hoa khai trương/chúc mừng SP000110', 'L009', 1900000.00, 22, 'Kệ hoa khai trương/chúc mừng SP000110', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/2000-4-1722653843954.jpg?v=1760432518220', 'còn hàng'),
('H075', 'Kệ hoa khai trương/chúc mừng SP000113', 'L009', 2200000.00, 22, 'Kệ hoa khai trương/chúc mừng SP000113', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/2500-4-1722653837044.jpg?v=1760432519433', 'còn hàng'),
('H076', 'Kệ hoa khai trương/chúc mừng SP000114', 'L009', 2500000.00, 22, 'Kệ hoa khai trương/chúc mừng SP000114', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/2500-1722653835128.jpg?v=1760432519753', 'còn hàng'),
('H077', 'Kệ hoa khai trương/chúc mừng SP000115', 'L009', 2200000.00, 32, 'Kệ hoa khai trương/chúc mừng SP000115', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/2500-3-1722653838339.jpg?v=1760432519480', 'còn hàng'),
('H078', 'Kệ hoa chúc mừng' , 'L009', 1800000.00, 32, 'Kệ hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/ea3d5ac32f1f48929e21de1702ffe5-jpeg-1722654141569.jpg?v=1760432518077', 'còn hàng'),
('H079', 'Kệ hoa chúc mừng,lẳng hoa khai tương',   'L009', 1500000.00, 32, 'Kệ hoa chúc mừng,lẳng hoa khai tương', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/74f67376-3ef8-4846-8b7d-6645cede93cc-bce2fad8-7ad4-4d5e-b3a5-77b5e409b459.jpg?v=1760432516433', 'còn hàng'),
('H080', 'Kệ hoa khai trương vàng phối giấy xanh SP000070', 'L009', 1400000.00, 32, 'Kệ hoa khai trương vàng phối giấy xanh SP000070', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/834be8a9-accb-4020-b7a6-fc835e4b8e39-e5f4f7b1-d673-409a-a457-a142c37c827a.jpg?v=1760432516240', 'còn hàng'),
('H081', 'Kệ Hoa Khai Trương đỏ – hồng pastel Hồng Phát Rực Rỡ',   'L009', 1800000.00, 32, 'Kệ Hoa Khai Trương đỏ – hồng pastel Hồng Phát Rực Rỡ', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/kt2a5650-1747887004846.jpg?v=1760432517223', 'còn hàng'),
('H082', 'Kệ hoa khai trương SP000069', 'L009', 2000000.00, 22, 'Kệ hoa khai trương SP000069', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/88e59483-94a8-4b29-9a9c-dd33360a993f-897961ba-675f-4194-a664-9f2a36d4e761.jpg?v=1760432519190', 'còn hàng'),
('H083', 'Kệ hoa khai trương SP000071', 'L009', 2000000.00, 22, 'Kệ hoa khai trương SP000071', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/74286e4d90904bac802010454bc6aa-1722654044948.jpg?v=1760432519250', 'còn hàng'),
('H084', 'Kệ hoa khai trương- lẳng hoa chúc mừng',  'L009', 1700000.00, 21, 'Kệ hoa khai trương- lẳng hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/209766eb-bdb4-42cc-a543-e51018ceee7a-3f266a44-91dc-4813-b8bb-32f411ef2e05.jpg?v=1760432517313', 'còn hàng'),
('H085', 'Kệ hoa khai trương-lẳng hoa chúc mừng',  'L009', 2500000.00, 21, 'Kệ hoa khai trương-lẳng hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/a20d7db7-200f-4c8d-9332-aa5ddf31779b-d40f7b79-7666-4067-875b-3e7ea5c42b51.jpg?v=1760432519640', 'còn hàng'),
('H086', 'Kệ hoa khai trương,chúc mừng',  'L009', 1700000.00, 21, 'Kệ hoa khai trương-lẳng hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/0545951168fa4ff79b779abbc65e74-jpeg-1722654059820.jpg?v=1760432517980', 'còn hàng'),
('H087', 'Kệ hoa khai trương,hoa chúc mừng',  'L009', 1600000.00, 15, 'Kệ hoa khai trương,hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/ecba9488-abf6-43f6-8162-42cdb9c4cd2e-626b56b1-09e5-4d69-a683-d98bf09ed897.jpg?v=1760432516550', 'còn hàng'),
('H088', 'Kệ hoa khai trương,hoa chúc mừng',  'L009', 1800000.00, 5, 'Kệ hoa khai trương,hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/efc1bb68-2277-4da1-a62b-4692774f215f-b70f9784-a410-4af7-bc90-c227b69cb0f2.jpg?v=1760432517370', 'còn hàng'),
('H089', 'Kệ hoa khai trương,lẳng hoa chúc mừng',  'L009', 1500000.00, 25, 'Kệ hoa khai trương,lẳng hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/318c355a-9602-499d-8a1d-df5ca6b419e2-6c459fe6-7e15-45ad-ba7b-feaa00621f1f.jpg?v=1760432516483', 'còn hàng'),
('H090', 'Kệ hoa khai trương,lẳng hoa chúc mừng',  'L009', 3000000.00, 25, 'Kệ hoa khai trương,lẳng hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/41fb9b0c-94c4-448b-9934-0550c78e818a-c0598f5b-22f8-4316-8da5-9243db90f0ea.jpg?v=1760432520807', 'còn hàng'),
('H091', 'Kệ hoa khai trương,lẳng hoa chúc mừng', 'L009', 1700000.00, 31, 'Kệ hoa khai trương,lẳng hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/d64410fb-19ef-44aa-bcc1-c7d807a38df8-7fd69dce-124b-498b-ad6a-f29d36ad3cf7.jpg?v=1760432517813', 'còn hàng'),
('H092', 'Kệ hoa khai trương/chúc mừng SP000008', 'L009', 1600000.00, 31, 'Kệ hoa khai trương/chúc mừng SP000008', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/66268d10bd3748599235ea425d9059-1722653592009.jpg?v=1760432517550', 'còn hàng'),
('H093', 'Kệ hoa khai trương/chúc mừng SP000093', 'L009', 1450000.00, 31, 'Kệ hoa khai trương/chúc mừng sp000093', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1100-1722653577560.jpg?v=1760432516143', 'còn hàng'),
('H094', 'Kệ hoa khai trương/chúc mừng SP000097', 'L009', 1400000.00, 13, 'Kệ hoa khai trương/chúc mừng sp000097', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1500-2-1722653571496.jpg?v=1760432516197', 'còn hàng'),
('H095', 'Kệ hoa khai trương/chúc mừng SP000098', 'L009', 2000000.00, 13, 'Kệ hoa khai trương/chúc mừng sp000098', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1500-1722653569546.jpg?v=1760432517493', 'còn hàng'),
('H096', 'Kệ hoa khai trương/chúc mừng SP000099', 'L009', 1500000.00, 13, 'Kệ hoa khai trương/chúc mừng sp000099', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/7da57f65-624f-4c7d-9bde-f604691124c2-9d4a9199-28d5-414b-b289-eed2bd030554.jpg?v=1760432516610', 'còn hàng'),
('H097', 'Kệ hoa khai trương/chúc mừng SP0000100', 'L009', 2000000.00, 27, 'Kệ hoa khai trương/chúc mừng sp0000100', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1700-2-1722653566410.jpg?v=1760432519080', 'còn hàng'),

('H0110', N'lẳng hoa chúc mừng', 'L009', 1600000.00, 18, N'lẳng hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/90007983c08e494a9d99c8f83d16f1-jpeg-1722654149671.jpg?v=1760432517710', N'còn hàng'),

('H0111', N'Giỏ hoa tone hồng pastel – trắng', 'L0010', 1300000.00, 11, N'Giỏ hoa tone hồng pastel – trắng, dáng bán nguyệt, mang nét ngọt ngào – thanh lịch', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/dsc05924-1747883847164.jpg?v=1760432516040', N'còn hàng'),

('H0112', N'🌞 Giỏ Hoa Cam – Trắng – Lời Tri Ân Tươi Sáng & Ấm Áp', 'L0010', 650000.00, 12, N'🌞 Giỏ Hoa Cam – Trắng – Lời Tri Ân Tươi Sáng & Ấm Áp', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/d81ff475-f43e-4410-8d94-67dfa42eed26.jpg?v=1731985250873', N'còn hàng'),

('H0113', N'💼 Giỏ Hoa Sáp Hồng – Xanh Dương', 'L0010', 450000.00, 12, N'Giỏ Hoa Sáp Hồng – Xanh Dương: Chúc Mừng Trọng Thị & Sang Trọng Lịch Lãm', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/bbd87433-2175-413f-bc06-9f9f0d69a1f4-0769bbe2-5681-4978-af04-54803a4cb567.jpg?v=1760432523980', N'còn hàng'),

('H0114', N'Giỏ hoa hồng mix hồng trắng', 'L0010', 600000.00, 13, N'Giỏ hoa hồng mix hồng trắng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/506fec83-7c0c-4c95-934c-380b7c3fe0ff-25ffd02a-9702-46a4-9df9-8539b0fb8268.jpg?v=1760432525987', N'còn hàng'),

('H0115', N'Giỏ hoa khai trương,chúc mừng', 'L0010', 700000.00, 17, N'Giỏ hoa khai trương,chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/17e29066-6ba1-46c8-aa2f-7d8902971f88-cb06fb46-a261-46c7-b5e5-fba5f3f90535.jpg?v=1760432526690', N'còn hàng'),

('H0116', N'Chậu tulip', 'L0010', 1200000.00, 16, N'Chậu tulip', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/93b2da08-4c24-4af1-80b2-1469b8fbebad-2988918b-9fb3-4d7e-82e4-1ac979d8db6c.jpg?v=1760432515773', N'còn hàng'),

('H0117', N'Giỏ hoa hồng chúc mừng', 'L0010', 650000.00, 16, N'Giỏ hoa hồng chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/5844d8a8-b333-4d61-a857-4d57b922292b-614db907-6248-40c8-89d4-d63d64d35dfe.jpg?v=1760432526030', N'còn hàng'),

('H0118', N'Hộp hoa hồng xanh mix phăng,đồng tiền,cát tường', 'L0010', 650000.00, 16, N'Hộp hoa hồng xanh mix phăng,đồng tiền,cát tường', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/z5674686162213-eb1ab140741362a141e2c291f9c7fbe0-1722653232530-adc6ea3d-94cb-4223-b008-6f1392d5936e.jpg?v=1760432526790', N'còn hàng'),

('H0119', N'Giỏ hoa Phăng/Cát Tường mix hoa ly,hồng kem tú cầu', 'L0010', 700000.00, 15, N'Giỏ hoa Phăng/Cát Tường mix hoa ly,hồng kem tú cầu', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/b6d8c5f2-6953-461c-9586-e4620db6920a-357cc108-cd54-4cdb-93e3-4fa5f9e9ded2.jpg?v=1760432526857', N'còn hàng'),

('H0120', N'Giỏ hoa khai trương SP000004', 'L0010', 600000.00, 15, N'Giỏ hoa khai trương SP000004', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/5f956891d7cc47ad8b55520889bf75-1722653587944.jpg?v=1760432525523', N'còn hàng'),

('H0121', N'Giỏ hoa khai trương SP000005', 'L0010', 600000.00, 14, N'Giỏ hoa khai trương SP000005', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/323e9593-c79b-4539-bead-5e404249676e-d6765e1c-1dbf-4a21-8e71-4af2b6a4a061.jpg?v=1760432526193', N'còn hàng'),

('H0122', N'Giỏ hoa khai trương SP0000023', 'L0010', 1500000.00, 14, N'Giỏ hoa khai trương SP0000023', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/9065450b5c8742618c921e40b35d72-1722653628443.jpg?v=1760432516907', N'còn hàng'),

('H0123', N'Hộp Hoa Hồng trái tim SP000031', 'L0010', 800000.00, 12, N'Hộp Hoa Hồng trái tim SP000031', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/2d18e2cd34754ef9a0c4ac9a85b02e-1722653677419.jpg?v=1760432528207', N'còn hàng'),

('H0124', N'Hộp hoa Hồng SP000039', 'L0010', 800000.00, 12, N'Hộp hoa Hồng SP000039', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/74dc8083-004f-40c1-90b4-ab61037ab70f-8f3bc589-6343-4756-bad0-b76e17a57b9a.jpg?v=1760432528307', N'còn hàng'),

('H0125', N'Giỏ hoa chúc mừng', 'L0010', 450000.00, 11, N'Giỏ hoa chúc mừng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/85b4538030374625842be6d944fb91-jpeg-1722654065530.jpg?v=1760432524480', N'còn hàng'),

('H0126', N'Giỏ hoa tặng', 'L0010', 650000.00, 11, N'Giỏ hoa tặng', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/075264983fc24d8a83908f79bda4a8-jpeg-1722654096584.jpg?v=1760432527037', N'còn hàng'),

('H0127', N'hộp hoa tú cầu', 'L0010', 450000.00, 11, N'hộp hoa tú cầu', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/1b8594947c8b4fec91d72681aa350a-jpeg-1722654110593.jpg?v=1760432524520', N'còn hàng'),

('H0128', N'giỏ hoa sáp', 'L0010', 450000.00, 11, N'giỏ hoa sáp', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/50e04564b1b841c9b0ea43dbe64f11-jpeg-1722654111597.jpg?v=1760432524573', N'còn hàng'),

('H0129', N'hộp hoa sáp', 'L0010', 450000.00, 11, N'hộp hoa sáp', 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/0cca8e59-9a9c-4ab2-84ac-d6eb6e70e9a9-0b68cd02-0a34-4152-9b30-271bc2383a04.jpg?v=1760432524617', N'còn hàng'),

 ('H0130', N'Bó Hoa Hướng Dương', 'L011', 400000, 50,
 N'Rực Rỡ & Lạc Quan ngày tốt nghiệp',
 'https://bizweb.dktcdn.net/thumb/large/100/487/411/products/kt2a5725-1748932784453.jpg?v=1760432523103', N'còn hàng'),

 ('H0131', N'Bó Hoa Hồng Đỏ', 'L011', 800000, 40,
 N'Sang Trọng & Nồng Nàn',
 'https://bizweb.dktcdn.net/100/487/411/products/kt2a5763-1748932797773.jpg?v=1760432527893', N'còn hàng'),

 ('H0132', N'Cúc Tana', 'L011', 700000, 40,
 N'Dịu Dàng Như Ánh Sáng Ban Mai, Gói Trọn Một Ngày Bình Yên',
 'https://bizweb.dktcdn.net/100/487/411/products/gochoaxinh-com-564-1747907308008.jpg?v=1760432527453', N'còn hàng'),

 ('H0133', N'Bó Hoa Hồng Đỏ & Kem Tinh Tế', 'L011', 500000, 40,
 N'Yêu Từ Ánh Nhìn Đầu Tiên',
 'https://bizweb.dktcdn.net/100/487/411/products/gochoaxinh-com-064-1747906819351.jpg?v=1760432523810', N'còn hàng'),

 ('H0134', N'Bó Hoa Hồng & Đồng Tiền, Cát Tường', 'L011', 1200000, 40,
 N'Mộng Mơ Pastel',
 'https://bizweb.dktcdn.net/100/487/411/products/z6627827948270-77c577f191bca0887273fd45355e5fd5-1747906523997.jpg?v=1760432515307', N'còn hàng'),

 ('H0135', N'Cẩm Chướng Xanh Trắng & Hồng Môn', 'L011', 750000, 40,
 N'Bó Hoa “Lời Chúc Bình An”',
 'https://bizweb.dktcdn.net/100/487/411/products/dsc05510-1747888898698.jpg?v=1760432527510', N'còn hàng'),

 ('H0136', N'Bó Mẫu Đơn', 'L011', 600000, 40,
 N'“Dịu Dàng Như Ánh Sớm” – Peony trắng thanh khiết',
 'https://bizweb.dktcdn.net/100/487/411/products/dsc06024-1747888666528.jpg?v=1760432525900', N'còn hàng'),

 ('H0137', N'Hoa Hồng, Tulip và Hoa Đồng Tiền', 'L011', 1500000, 40,
 N'Bó Hoa “Thanh Âm Ngọt Ngào”',
 'https://bizweb.dktcdn.net/100/487/411/products/intagram11.jpg?v=1747887811143', N'còn hàng'),

 ('H0138', N'Bó Tulip Trắng', 'L011', 1700000, 40,
 N'Hương Pastel Tinh Khôi & Lãng Mạn',
 'https://bizweb.dktcdn.net/100/487/411/products/fb4-1747886601816.jpg?v=1760432517760', N'còn hàng'),

 ('H0139', N'Bó Hoa Hồng Đỏ 50 Bông', 'L011', 1400000, 40,
 N'Tình Yêu Nồng Nàn',
 'https://bizweb.dktcdn.net/100/487/411/products/dsc05975-1747886595425.jpg?v=1760432515707', N'còn hàng'),

 ('H0140', N'Bó Hoa Hồng & Tulip Trắng', 'L011', 1000000, 40,
 N'Sự Nhẹ Nhàng Tinh Khiết',
 'https://bizweb.dktcdn.net/100/487/411/products/intagram2-1747886570332.jpg?v=1760432514727', N'còn hàng'),

 ('H0141', N'Bó Hoa Hồng Xịt Sương Xanh', 'L011', 500000, 40,
 N'Sắc Trầm Thanh Nhã',
 'https://bizweb.dktcdn.net/100/487/411/products/dsc05539-1747886560955.jpg?v=1760432523153', N'còn hàng'),

 ('H0142', N'Bó Hoa Pastel Hồng', 'L011', 500000, 40,
 N'Ngọt Ngào Như Lời Tỏ Tình',
 'https://bizweb.dktcdn.net/100/487/411/products/a6fb1be2-bcc9-4572-ad7a-1669212e2c49-fea9b875-1f95-4d2b-b535-0100f4ae28c1.jpg?v=1760432523887', N'còn hàng'),

 ('H0143', N'Bó Hoa Hồng Trắng & Cẩm Tú Cầu', 'L011', 400000, 0,
 N'Thanh Lịch & Tinh Khiết',
 'https://bizweb.dktcdn.net/100/487/411/products/52dc4541-d249-4d31-b317-b191368ee542-d492d8a5-2483-4253-96b8-de7067751c16.jpg?v=1760432523200', N'hết hàng'),

 ('H0144', N'Bó Hoa Pastel Đa Sắc', 'L011', 700000, 0,
 N'Sang Trọng & Rực Rỡ',
 'https://bizweb.dktcdn.net/100/487/411/products/1ff30eb5-5157-4691-a209-7899f59170fb-f8ae7aba-2517-4fab-8674-0d50802ea306.jpg?v=1760432527613', N'hết hàng'),

 ('H0145', N'Bó Hoa Hồng Pastel Kem', 'L011', 350000, 0,
 N'Tối Giản & Thanh Lịch',
 'https://bizweb.dktcdn.net/100/487/411/products/a48c651d-c26c-4bf4-aee5-b317149d6ef0-f3894dde-e70d-43a3-94e5-da58d367a001.jpg?v=1760432521673', N'hết hàng');


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
('KH003', N'Lê Quốc Huy', 'quochuy.le@example.com', '0987654321', N'89 Cầu Giấy, Quận Cầu Giấy, Hà Nội', '2025-02-10'),
('KH004',N'user','user@gmail.com','','','');