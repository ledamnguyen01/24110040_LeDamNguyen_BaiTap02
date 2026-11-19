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
@WebServlet(urlPatterns = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    private UserService service = new UserServiceImpl();
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        req.setAttribute("email_val", email);

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập địa chỉ email đã đăng ký!");
            req.getRequestDispatcher("/views/forgot-password.jsp").include(req, resp);
            return;
        }

        if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            req.setAttribute("alert", "Địa chỉ email không đúng định dạng!");
            req.getRequestDispatcher("/views/forgot-password.jsp").include(req, resp);
            return;
        }

        boolean sent = service.forgotPassword(email.trim());
        if (sent) {
            req.setAttribute("email", email.trim());
            req.setAttribute("message", "Mã xác thực OTP đã được gửi đến email " + email.trim() + ". Vui lòng nhập mã để tạo mật khẩu mới.");
            req.getRequestDispatcher("/views/verify-forgot.jsp").include(req, resp);
        } else {
            req.setAttribute("alert", "Địa chỉ email không tồn tại trong hệ thống!");
            req.getRequestDispatcher("/views/forgot-password.jsp").include(req, resp);
        }
    }
}
