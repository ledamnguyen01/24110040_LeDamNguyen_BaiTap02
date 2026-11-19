# BÀI TẬP 04: CẤU HÌNH SITEMESH DECORATOR 3 VỚI BOOTSTRAP & FORM VALIDATION

- **Họ và tên sinh viên:** Lê Đàm Nguyên
- **Mã số sinh viên (MSSV):** 24110040
- **Trường:** Đại học Sư phạm Kỹ thuật TP.HCM (HCMUTE)
- **Môn học:** Lập trình Web
- **Giảng viên hướng dẫn:** ThS. Nguyễn Hữu Trung
- **Thời hạn nộp Mốc 1:** Trước 16:00 ngày 19/11/2026
- **Kho lưu trữ GitHub:** [https://github.com/ledamnguyen01/24110040_LeDamNguyen_BaiTap04](https://github.com/ledamnguyen01/24110040_LeDamNguyen_BaiTap04)

---

## 1. NỘI DUNG VÀ YÊU CẦU ĐÃ HOÀN THÀNH

### Yêu cầu 1: Cấu hình Sitemesh Decorator 3 với Template Bootstrap (Mốc 16:00 ngày 19/11/2026)
1. **Thư viện SiteMesh 3:** Sử dụng `org.sitemesh:sitemesh-webfilter:3.3.0` tương thích chuẩn **Jakarta EE 10** và Apache Tomcat 11.
2. **Cấu hình Filter trong `web.xml`:** Khai báo `ConfigurableSiteMeshFilter` bắt tất cả các đường dẫn `/*`.
3. **Cấu hình `sitemesh3.xml`:**
   - Cấu hình thẻ `<decorator-prefix>/WEB-INF/decorators/</decorator-prefix>`.
   - Layout trang người dùng / khách: `<mapping path="/*" name="web" decorator="web.jsp" />`.
   - Layout trang quản trị Admin: `<mapping path="/admin/*" name="admin" decorator="admin.jsp" />`.
   - Loại trừ tài nguyên tĩnh, API và media streaming: `<mapping path="/api*" exclude="true" />`, `/image*`, `/video/stream*`, `/templates/*`, `/uploads/*`.
4. **Cấu trúc thư mục theo đúng slide hướng dẫn của Thầy Trung:**
   - `webapp/common/admin`: `header.jsp`, `left.jsp`, `footer.jsp`.
   - `webapp/common/web`: `topbar.jsp`, `header.jsp`, `navbar.jsp`, `left.jsp`, `footer.jsp`.
   - `webapp/common/info.jsp` & `taglib.jsp`.
   - `webapp/views/`: Chứa các trang nội dung content.
   - `webapp/WEB-INF/decorators/`: Chứa các trang layout `web.jsp`, `admin.jsp`, `login.jsp`.

### Yêu cầu 2: Thực hiện Validation cho những chức năng có FORM (Mốc 16:00 ngày 19/11/2026)
Áp dụng cơ chế **Validation 2 lớp** (Client-side bằng Bootstrap 5 `needs-validation` và Server-side trong Servlet Controller):
1. **Form Đăng nhập (`/login`):**
   - Client-side: `required`, kiểm tra không để trống tên đăng nhập và mật khẩu, phản hồi trực quan bằng `invalid-feedback`.
   - Server-side: Kiểm tra rỗng, mã hóa băm mật khẩu `jBCrypt` kiểm tra tính hợp lệ, kiểm tra kích hoạt tài khoản OTP (status).
2. **Form Đăng ký (`/register`):**
   - Client-side: Tên đăng nhập chuẩn regex (3-30 ký tự `^[a-zA-Z0-9_]{3,30}$`), họ tên min 2 ký tự, email chuẩn RFC, số điện thoại chuẩn VN 10 số (`^0[0-9]{9}$`), mật khẩu tối thiểu 6 ký tự, xác nhận mật khẩu khớp.
   - Server-side: Kiểm tra độ dài, regex email/sđt, kiểm tra trùng lặp `checkExistUsername`, `checkExistEmail`, `checkExistPhone` trong cơ sở dữ liệu.
3. **Form Quên mật khẩu & Đặt lại mật khẩu (`/forgot-password`, `/verify-forgot`):**
   - Client-side: Kiểm tra email hợp lệ, kiểm tra mã OTP đúng 6 chữ số, mật khẩu mới tối thiểu 6 ký tự.
   - Server-side: Kiểm tra email tồn tại trong CSDL, tạo OTP ngẫu nhiên 6 số gửi qua Email, xác thực OTP khớp và chưa hết hạn, hash mật khẩu mới bằng BCrypt.
4. **Form Thêm mới & Chỉnh sửa Danh mục (`/admin/category/add`, `/admin/category/edit`):**
   - Client-side: Kiểm tra tên danh mục bắt buộc, độ dài từ 2 đến 100 ký tự.
   - Server-side: Kiểm tra rỗng, xử lý upload icon bằng `@MultipartConfig`.
5. **Form Thêm mới & Chỉnh sửa Video (`/video/add`, `/video/edit`):**
   - Client-side: Tiêu đề video tối thiểu 3 ký tự, chọn file poster hoặc file video MP4.
   - Server-side: Kiểm tra độ dài tiêu đề, kiểm tra phiên đăng nhập người sở hữu video, lưu trữ an toàn bằng `@MultipartConfig`.

### Yêu cầu 3: Chức năng Profile User & Cloudinary Multipart Upload
1. **URL:** `/profile`
2. Cập nhật thông tin: `fullname`, `phone`.
3. **Upload Avatar Cloudinary:** Sử dụng `@MultipartConfig` kết hợp `com.cloudinary:cloudinary-http44:1.39.0`, lưu trực tiếp lên Cloudinary CDN và tự động fallback lưu cục bộ nếu môi trường không có mạng ngoài.
4. **Cập nhật Email mới:** Khi người dùng nhập email mới, hệ thống tự động phát sinh mã OTP 6 số gửi đến địa chỉ email mới. Người dùng nhập đúng mã OTP thì hệ thống mới chính thức cập nhật email trong database và session.

---

## 2. HƯỚNG DẪN CÀI ĐẶT & CHẠY DỰ ÁN
1. **Cơ sở dữ liệu:** Mở SQL Server Management Studio, chạy tệp tin `database.sql` để tạo CSDL `ShoppingServiceMVC` và các bảng `[User]`, `Category`, `Videos`.
2. **Biên dịch dự án:**
   ```bash
   mvn clean package -DskipTests
   ```
3. **Triển khai:** Copy tệp tin `target/BaiTap04_SiteMesh_Validation.war` vào thư mục `webapps` của Apache Tomcat 11.
4. **Truy cập ứng dụng:** Mở trình duyệt web và truy cập `http://localhost:8080/BaiTap04/home`.
