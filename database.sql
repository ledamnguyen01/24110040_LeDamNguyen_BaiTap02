-- ===============================================================
-- HỌ VÀ TÊN: LÊ ĐÀM NGUYÊN
-- MSSV: 24110040
-- MÔN HỌC: LẬP TRÌNH WEB (HCMUTE) - THS. NGUYỄN HỮU TRUNG
-- BÀI TẬP 02: MVC 3-TIER - HASH PASSWORD (BCRYPT) - OTP EMAIL KÍCH HOẠT & QUÊN MẬT KHẨU
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

-- ===============================================================
-- DỮ LIỆU MẪU BAN ĐẦU
-- ===============================================================

-- Thêm tài khoản mẫu (Mật khẩu '123456' hoặc hash BCrypt)
INSERT INTO [User] (username, password, email, fullname, phone, roleid, status) VALUES
('admin', '$2a$10$w0IomH8zL.6W1O8Q9Q.Vee2f6j/H7o7W9lAepfXG.0cWJ2GjHhH2S', 'admin@gmail.com', N'Quản Trị Viên', '0901234567', 1, 1),
('user', '$2a$10$w0IomH8zL.6W1O8Q9Q.Vee2f6j/H7o7W9lAepfXG.0cWJ2GjHhH2S', 'user@gmail.com', N'Nguyễn Văn A', '0907654321', 5, 1),
('damnguyen', '$2a$10$w0IomH8zL.6W1O8Q9Q.Vee2f6j/H7o7W9lAepfXG.0cWJ2GjHhH2S', 'ledamnguyen01@gmail.com', N'Lê Đàm Nguyên', '0912345678', 5, 1);
GO

-- Thêm danh mục mẫu (Hình ảnh nằm trong D:\upload)
INSERT INTO Category (cate_name, icons) VALUES
(N'Áo Nam', 'ao_nam.png'),
(N'Áo Nữ', 'ao_nu.png'),
(N'Giày Dép', 'giay_dep.png');
GO

-- Kiểm tra dữ liệu
SELECT * FROM [User];
SELECT * FROM Category;
GO
