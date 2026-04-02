$(function () {

    // Lắng nghe sự kiện click trên các nút có class 'add-to-cart-ajax'
    $('.add-to-cart-ajax').on('click', function (e) {
        e.preventDefault();

        // Lấy MaHoa và Số lượng từ thuộc tính data
        var maHoa = $(this).data('mahoa');
        var soLuong = $(this).data('soluong') || 1; // Mặc định là 1

        // Kiểm tra MaHoa hợp lệ trước khi gửi
        if (!maHoa) {
            console.error("Không tìm thấy Mã Hoa.");
            return;
        }

        // Gửi yêu cầu AJAX
        $.ajax({
            url: ThemGioHangUrl, // Đảm bảo đúng Controller và Action
            type: 'POST',
            data: {
                maHoa: maHoa,
                soLuong: soLuong
            },
            success: function (response) {
                console.log("AJAX Response:", response);
                if (response.success) {
                    // Thông báo thành công và cập nhật UI
                    alert(response.message);
                    $('#cart-count').text(response.totalQuantity);
                    // Ví dụ: Cập nhật số lượng sản phẩm trên icon giỏ hàng (nếu có)
                    // updateCartCount(response.newCount); 
                } else {
                    // Xử lý lỗi (ví dụ: lỗi MaHoa không tồn tại)
                    alert("Lỗi: " + response.message);
                }
            },
            error: function () {
                // Xử lý lỗi kết nối
                alert('Có lỗi xảy ra khi kết nối đến máy chủ.');
            }
        });
    });
});
$(document).on('click', '.btn-delete-cart-item', function (e) {
    e.preventDefault();

    // Lấy mã hoa cần xóa từ thuộc tính data-mahoa của nút
    var maHoa = $(this).data('mahoa');

    if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?")) {
        $.ajax({
            url: XoaGioHangUrl, // Sửa đường dẫn nếu cần
            type: 'POST',
            data: { maHoa: maHoa },
            dataType: 'json',
            success: function (response) {
                alert(response.message);
                if (response.success) {
                    // Cập nhật lại số lượng trên icon
                    $('#cart-count').text(response.totalQuantity);
                    // Tải lại trang hoặc xóa dòng sản phẩm trên giao diện
                    location.reload();
                    // Hoặc: $(e.target).closest('tr').remove();
                }
            },
            error: function (xhr, status, error) {
                alert("Có lỗi xảy ra khi kết nối đến máy chủ.");
                console.error(xhr.responseText);
            }
        });
    }
});