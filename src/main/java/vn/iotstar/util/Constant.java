package vn.iotstar.util;

public class Constant {
    public static final String DIR = "D:\\upload";
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";
    
    // Cấu hình gửi mail OTP qua Google SMTP (Port 587)
    public static final String SENDER_EMAIL = "laptrinhwebhcmute@gmail.com";
    public static final String SENDER_PASSWORD = "app_password_here"; // Mật khẩu ứng dụng (App Password 16 ký tự của Gmail)

    public static class Path {
        public static final String LOGIN = "/views/login.jsp";
        public static final String REGISTER = "/views/register.jsp";
        public static final String ADMIN_HOME = "/views/admin/home.jsp";
        public static final String HOME = "/views/home.jsp";
    }
}
