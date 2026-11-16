package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/verify-forgot")
public class VerifyForgotController extends HttpServlet {
    private UserService service = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if (email != null) {
            req.setAttribute("email", email);
        }
        req.getRequestDispatcher("/views/verify-forgot.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (email == null || otp == null || newPassword == null || confirmPassword == null ||
            otp.trim().isEmpty() || newPassword.trim().isEmpty()) {
            req.setAttribute("email", email);
            req.setAttribute("alert", "Vui lòng nhập đầy đủ mã OTP và mật khẩu mới!");
            req.getRequestDispatcher("/views/verify-forgot.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("email", email);
            req.setAttribute("alert", "Mật khẩu xác nhận không khớp với mật khẩu mới!");
            req.getRequestDispatcher("/views/verify-forgot.jsp").forward(req, resp);
            return;
        }

        boolean reset = service.resetPassword(email.trim(), otp.trim(), newPassword);
        if (reset) {
            req.setAttribute("message", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("email", email);
            req.setAttribute("alert", "Mã xác thực OTP không đúng hoặc đã hết hạn!");
            req.getRequestDispatcher("/views/verify-forgot.jsp").forward(req, resp);
        }
    }
}
