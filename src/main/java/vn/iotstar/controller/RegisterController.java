package vn.iotstar.controller;

import java.io.IOException;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private UserService service = new UserServiceImpl();

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^0[0-9]{9}$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,30}$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }
        req.getRequestDispatcher("/views/register.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String repassword = req.getParameter("repassword");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // Giữ lại giá trị nhập của người dùng nếu có lỗi
        req.setAttribute("username_val", username);
        req.setAttribute("fullname_val", fullname);
        req.setAttribute("email_val", email);
        req.setAttribute("phone_val", phone);

        // Server-side Validation
        if (username == null || !USERNAME_PATTERN.matcher(username.trim()).matches()) {
            req.setAttribute("alert", "Tên đăng nhập phải từ 3 đến 30 ký tự và chỉ chứa chữ cái, số, dấu gạch dưới!");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
            return;
        }

        if (fullname == null || fullname.trim().length() < 2) {
            req.setAttribute("alert", "Họ và tên không được để trống và phải từ 2 ký tự trở lên!");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
            return;
        }

        if (email == null || !EMAIL_PATTERN.matcher(email.trim()).matches()) {
            req.setAttribute("alert", "Địa chỉ email không đúng định dạng!");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
            return;
        }

        if (phone == null || !PHONE_PATTERN.matcher(phone.trim()).matches()) {
            req.setAttribute("alert", "Số điện thoại không hợp lệ! Vui lòng nhập đúng 10 chữ số bắt đầu bằng số 0.");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
            return;
        }

        if (password == null || password.length() < 6) {
            req.setAttribute("alert", "Mật khẩu phải có độ dài tối thiểu 6 ký tự!");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
            return;
        }

        if (repassword != null && !password.equals(repassword)) {
            req.setAttribute("alert", "Xác nhận mật khẩu không trùng khớp!");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
            return;
        }

        if (service.checkExistUsername(username.trim())) {
            req.setAttribute("alert", "Tên đăng nhập đã tồn tại trong hệ thống! Vui lòng chọn tên khác.");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
            return;
        }

        if (service.checkExistEmail(email.trim())) {
            req.setAttribute("alert", "Địa chỉ email đã được sử dụng bởi tài khoản khác!");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
            return;
        }

        if (service.checkExistPhone(phone.trim())) {
            req.setAttribute("alert", "Số điện thoại đã được đăng ký bởi tài khoản khác!");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
            return;
        }

        boolean isSuccess = service.register(username.trim(), password, email.trim(), fullname.trim(), phone.trim());
        if (isSuccess) {
            req.setAttribute("email", email.trim());
            req.setAttribute("message", "Đăng ký thành công! Mã OTP kích hoạt đã được gửi đến email " + email + ". Vui lòng nhập mã để kích hoạt tài khoản.");
            req.getRequestDispatcher("/views/verify-register.jsp").include(req, resp);
        } else {
            req.setAttribute("alert", "Lỗi hệ thống khi đăng ký! Vui lòng thử lại.");
            req.getRequestDispatcher("/views/register.jsp").include(req, resp);
        }
    }
}
