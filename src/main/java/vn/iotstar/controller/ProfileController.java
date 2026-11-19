package vn.iotstar.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.CloudinaryUtil;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/profile", "/profile/update", "/profile/verify-email" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 20     // 20MB
)
public class ProfileController extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^0[0-9]{9}$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("account");
        User currentUser = userService.findById(sessionUser.getId());
        if (currentUser == null) {
            currentUser = userService.get(sessionUser.getUserName());
        }
        if (currentUser != null) {
            session.setAttribute("account", currentUser);
            req.setAttribute("user", currentUser);
        } else {
            req.setAttribute("user", sessionUser);
        }

        req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("account");
        User currentUser = userService.findById(sessionUser.getId());
        if (currentUser == null) {
            currentUser = sessionUser;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "update_info";
        }

        // ===============================================================
        // 1. XÁC NHẬN MÃ OTP CẬP NHẬT EMAIL MỚI
        // ===============================================================
        if ("verify_email_otp".equals(action)) {
            String otp = req.getParameter("otp");
            String pendingEmail = (String) session.getAttribute("pending_email");
            if (pendingEmail == null) {
                pendingEmail = req.getParameter("pending_email");
            }

            if (otp == null || otp.trim().length() != 6) {
                req.setAttribute("alert", "Vui lòng nhập đúng 6 chữ số mã OTP!");
                req.setAttribute("requireOtp", true);
                req.setAttribute("pending_email", pendingEmail);
                req.setAttribute("user", currentUser);
                req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
                return;
            }

            boolean confirmed = userService.confirmUpdateEmail(currentUser.getId(), pendingEmail, otp.trim());
            if (confirmed) {
                currentUser.setEmail(pendingEmail);
                session.setAttribute("account", currentUser);
                session.removeAttribute("pending_email");
                req.setAttribute("message", "Xác thực OTP thành công! Địa chỉ email đã được cập nhật thành: " + pendingEmail);
            } else {
                req.setAttribute("alert", "Mã OTP không chính xác hoặc đã hết hạn!");
                req.setAttribute("requireOtp", true);
                req.setAttribute("pending_email", pendingEmail);
            }

            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
            return;
        }

        // ===============================================================
        // 2. CẬP NHẬT THÔNG TIN PROFILE (FULLNAME, PHONE, AVATAR, EMAIL)
        // ===============================================================
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        // Server-side Validation
        if (fullname == null || fullname.trim().length() < 2) {
            req.setAttribute("alert", "Họ và tên không được để trống và phải từ 2 ký tự trở lên!");
            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
            return;
        }

        if (phone == null || !PHONE_PATTERN.matcher(phone.trim()).matches()) {
            req.setAttribute("alert", "Số điện thoại không hợp lệ! Vui lòng nhập đúng 10 chữ số bắt đầu bằng số 0.");
            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
            return;
        }

        if (email == null || !EMAIL_PATTERN.matcher(email.trim()).matches()) {
            req.setAttribute("alert", "Địa chỉ email không đúng định dạng!");
            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
            return;
        }

        // Xử lý upload avatar (Cloudinary qua Multipart)
        String avatarUrl = currentUser.getAvatar();
        try {
            Part part = req.getPart("avatar");
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String submittedName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

                // Đọc bytes từ InputStream
                InputStream is = part.getInputStream();
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                int nRead;
                byte[] data = new byte[4096];
                while ((nRead = is.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                buffer.flush();
                byte[] fileBytes = buffer.toByteArray();

                // Upload lên Cloudinary
                String cloudUrl = CloudinaryUtil.uploadBytes(fileBytes, currentUser.getUserName());
                if (cloudUrl != null && !cloudUrl.isEmpty()) {
                    avatarUrl = cloudUrl;
                } else {
                    // Fallback lưu local nếu Cloudinary không khả dụng
                    File uploadDir = new File(Constant.DIR);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    int index = submittedName.lastIndexOf(".");
                    String ext = (index >= 0) ? submittedName.substring(index + 1) : "png";
                    String localFileName = "avatar_" + System.currentTimeMillis() + "." + ext;
                    part.write(Constant.DIR + File.separator + localFileName);
                    avatarUrl = localFileName;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        currentUser.setFullName(fullname.trim());
        currentUser.setPhone(phone.trim());
        currentUser.setAvatar(avatarUrl);
        userService.updateProfile(currentUser);

        // Kiểm tra nếu người dùng thay đổi email mới
        boolean emailChanged = false;
        String newEmail = email.trim();
        if (!newEmail.equalsIgnoreCase(currentUser.getEmail())) {
            // Kiểm tra xem email mới đã có người khác dùng chưa
            if (userService.checkExistEmail(newEmail)) {
                req.setAttribute("alert", "Email '" + newEmail + "' đã được sử dụng bởi tài khoản khác! Các thông tin khác đã được lưu.");
                req.setAttribute("user", currentUser);
                session.setAttribute("account", currentUser);
                req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
                return;
            }

            // Gửi OTP xác thực đến email mới
            boolean sent = userService.requestUpdateEmail(currentUser.getId(), newEmail, currentUser.getFullName());
            if (sent) {
                session.setAttribute("pending_email", newEmail);
                req.setAttribute("requireOtp", true);
                req.setAttribute("pending_email", newEmail);
                req.setAttribute("message", "Thông tin đã lưu! Mã OTP xác nhận đã được gửi đến email mới: " + newEmail + ". Vui lòng nhập OTP để hoàn tất thay đổi email.");
                emailChanged = true;
            } else {
                req.setAttribute("alert", "Không thể gửi OTP đến email mới. Vui lòng thử lại!");
            }
        } else {
            req.setAttribute("message", "Cập nhật hồ sơ cá nhân thành công!");
        }

        session.setAttribute("account", currentUser);
        req.setAttribute("user", currentUser);
        req.getRequestDispatcher("/views/profile.jsp").include(req, resp);
    }
}
