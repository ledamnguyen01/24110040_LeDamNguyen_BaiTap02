package vn.iotstar.controller;

import java.io.IOException;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/verify-register")
public class VerifyRegisterController extends HttpServlet {
    private UserService service = new UserServiceImpl();
    private static final Pattern OTP_PATTERN = Pattern.compile("^[0-9]{6}$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if (email != null) {
            req.setAttribute("email", email);
        }
        req.getRequestDispatcher("/views/verify-register.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        if (email == null || email.trim().isEmpty() || otp == null || !OTP_PATTERN.matcher(otp.trim()).matches()) {
            req.setAttribute("email", email);
            req.setAttribute("alert", "Vui lòng nhập đúng 6 chữ số mã OTP xác thực!");
            req.getRequestDispatcher("/views/verify-register.jsp").include(req, resp);
            return;
        }

        boolean isVerified = service.verifyOtp(email.trim(), otp.trim());
        if (isVerified) {
            req.setAttribute("message", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.");
            req.getRequestDispatcher("/views/login.jsp").include(req, resp);
        } else {
            req.setAttribute("email", email);
            req.setAttribute("alert", "Mã xác thực OTP không đúng hoặc đã hết hạn!");
            req.getRequestDispatcher("/views/verify-register.jsp").include(req, resp);
        }
    }
}
