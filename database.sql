-- ===============================================================
-- HỌ VÀ TÊN: LÊ ĐÀM NGUYÊN
-- MSSV: 24110040
-- MÔN HỌC: LẬP TRÌNH WEB (HCMUTE) - THS. NGUYỄN HỮU TRUNG
-- BÀI TẬP 02: MVC 3-TIER - HASH PASSWORD (BCRYPT) - OTP EMAIL - QUẢN LÝ VIDEOS (1-N VỚI USER)
-- ===============================================================

CREATE DATABASE ShoppingServiceMVC;
GO

USE ShoppingServiceMVC;
GO

-- 1. BẢNG USER (Dành cho chức năng Login, Remember Me, Register OTP, Forgot Password OTP)
CREATE TABLE [User] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fullname NVARCHAR(100) NOT NULL,
    phone VARCHAR(20) NULL,
    roleid INT NOT NULL DEFAULT 5, -- 1: Admin, 2: Manager, 5: Khách hàng
    createdate DATE DEFAULT GETDATE(),
    status INT NOT NULL DEFAULT 1, -- 0: Chưa kích hoạt OTP, 1: Đã kích hoạt
    code VARCHAR(10) NULL,         -- Mã OTP (6 số ngẫu nhiên)
    code_time DATETIME NULL        -- Thời điểm phát sinh mã OTP
);
GO

-- 2. BẢNG CATEGORY (Dành cho chức năng CRUD Category & Upload hình ảnh)
CREATE TABLE Category (
    cate_id INT IDENTITY(1,1) PRIMARY KEY,
    cate_name NVARCHAR(200) NOT NULL,
    icons NVARCHAR(255) NULL
);
GO

-- 3. BẢNG VIDEOS (Mối quan hệ 1-N với bảng [User])
CREATE TABLE Videos (
    videoId INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    poster NVARCHAR(255) NULL,
    videoFile NVARCHAR(255) NULL,
    views INT DEFAULT 0,
    description NVARCHAR(MAX) NULL,
    active BIT DEFAULT 1,
    createDate DATETIME DEFAULT GETDATE(),
    userId INT NOT NULL FOREIGN KEY REFERENCES [User](id)
);
GO

-- ===============================================================
-- DỮ LIỆU MẪU BAN ĐẦU
-- ===============================================================

-- Thêm tài khoản mẫu (Mật khẩu '123456' hoặc hash BCrypt)
INSERT INTO [User] (username, password, email, fullname, phone, roleid, status) VALUES
('admin', '$2a$10$w0IomH8zL.6W1O8Q9Q.Vee2f6j/H7o7W9lAepfXG.0cWJ2GjHhH2S', 'admin@gmail.com', N'Quản Trị Viên', '0901234567', 1, 1),
('user', '$2a$10$w0IomH8zL.6W1O8Q9Q.Vee2f6j/H7o7W9lAepfXG.0cWJ2GjHhH2S', 'user@gmail.com', N'Nguyễn Văn A', '0907654321', 5, 1),
('damnguyen', '$2a$10$w0IomH8zL.6W1O8Q9Q.Vee2f6j/H7o7W9lAepfXG.0cWJ2GjHhH2S', 'ledamnguyen01@gmail.com', N'Lê Đàm Nguyên', '0912345678', 5, 1);
GO

-- Thêm danh mục mẫu
INSERT INTO Category (cate_name, icons) VALUES
(N'Áo Nam', 'ao_nam.png'),
(N'Áo Nữ', 'ao_nu.png'),
(N'Giày Dép', 'giay_dep.png');
GO

-- Thêm video mẫu liên kết với User id = 1
INSERT INTO Videos (title, poster, videoFile, views, description, active, createDate, userId) VALUES
(N'Hướng dẫn Lập trình Web Servlet & JSP từ cơ bản', 'video_poster_1.png', 'sample_video.mp4', 125, N'Video hướng dẫn xây dựng ứng dụng web với Jakarta EE và Tomcat 11.', 1, DATEADD(minute, -60, GETDATE()), 1),
(N'Mô hình MVC 3 tầng trong Java Web', 'video_poster_2.png', 'sample_video.mp4', 98, N'Tìm hiểu kiến trúc Model-View-Controller và tách bạch các tầng.', 1, DATEADD(minute, -55, GETDATE()), 1),
(N'Xác thực tài khoản bằng OTP qua Email', 'video_poster_3.png', 'sample_video.mp4', 210, N'Tích hợp Jakarta Mail API gửi OTP xác thực đăng ký tài khoản.', 1, DATEADD(minute, -50, GETDATE()), 1),
(N'Mã hóa mật khẩu an toàn với BCrypt', 'video_poster_4.png', 'sample_video.mp4', 180, N'Bảo mật ứng dụng web với thuật toán băm mật khẩu có Salt.', 1, DATEADD(minute, -45, GETDATE()), 1),
(N'Upload file đa năng với Servlet @MultipartConfig', 'video_poster_5.png', 'sample_video.mp4', 75, N'Xử lý upload ảnh và video lên server dùng Jakarta Servlet.', 1, DATEADD(minute, -40, GETDATE()), 1),
(N'Kỹ thuật phân trang dữ liệu trong SQL Server', 'video_poster_6.png', 'sample_video.mp4', 150, N'Sử dụng mệnh đề OFFSET và FETCH NEXT để phân trang mượt mà.', 1, DATEADD(minute, -35, GETDATE()), 1),
(N'Quản lý Session và Cookie Remember Me', 'video_poster_7.png', 'sample_video.mp4', 88, N'Duy trì phiên đăng nhập và tự động ghi nhớ đăng nhập người dùng.', 1, DATEADD(minute, -30, GETDATE()), 1),
(N'Thiết kế CSDL quan hệ 1 - N cho hệ thống Video', 'video_poster_8.png', 'sample_video.mp4', 64, N'Phân tích thực thể, khóa chính, khóa ngoại giữa User và Videos.', 1, DATEADD(minute, -25, GETDATE()), 1),
(N'Lập trình Web nâng cao với JDBC Transaction', 'video_poster_9.png', 'sample_video.mp4', 112, N'Đảm bảo tính toàn vẹn dữ liệu ACID khi thao tác nhiều bảng.', 1, DATEADD(minute, -20, GETDATE()), 1),
(N'Tối ưu hóa hiệu năng và bảo mật ứng dụng Web', 'video_poster_10.png', 'sample_video.mp4', 320, N'Chống tấn công XSS, SQL Injection và cấu hình cache.', 1, DATEADD(minute, -15, GETDATE()), 1),
(N'Video số 11: Demo tính năng phát video HTML5', 'video_poster_11.png', 'sample_video.mp4', 45, N'Kiểm tra phân trang trang 2 với 6 sản phẩm mỗi trang.', 1, DATEADD(minute, -10, GETDATE()), 1),
(N'Video số 12: Tổng kết đồ án Lập trình Web', 'video_poster_12.png', 'sample_video.mp4', 510, N'Hướng dẫn báo cáo và đóng gói mã nguồn nộp đồ án.', 1, DATEADD(minute, -5, GETDATE()), 1);
GO

-- Kiểm tra dữ liệu
SELECT * FROM [User];
SELECT * FROM Category;
SELECT * FROM Videos;
GO
