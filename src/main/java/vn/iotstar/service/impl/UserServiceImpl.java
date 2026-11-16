package vn.iotstar.service.impl;

import java.util.Random;
import org.mindrot.jbcrypt.BCrypt;
import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.util.EmailUtil;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        if (user == null) {
            // Cho phép người dùng đăng nhập bằng cả username hoặc email
            user = this.findByEmail(username);
        }
        if (user != null) {
            String storedPass = user.getPassWord();
            boolean isMatch = false;
            // Kiểm tra nếu mật khẩu trong DB đã được hash bằng BCrypt
            if (storedPass != null && (storedPass.startsWith("$2a$") || storedPass.startsWith("$2b$") || storedPass.startsWith("$2y$"))) {
                try {
                    isMatch = BCrypt.checkpw(password, storedPass);
                } catch (Exception e) {
                    isMatch = false;
                }
            } else {
                // Tương thích ngược với các tài khoản cũ lưu mật khẩu plain text
                isMatch = password.equals(storedPass);
            }

            if (isMatch) {
                return user;
            }
        }
        return null;
    }

    @Override
    public User get(String username) {
        return userDao.get(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) {
            return false;
        }

        // Mã hóa mật khẩu bằng BCrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(10));

        // Sinh mã OTP ngẫu nhiên 6 số
        String otp = String.format("%06d", new Random().nextInt(999999));

        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);
        java.sql.Timestamp now = new java.sql.Timestamp(millis);

        User newUser = new User();
        newUser.setEmail(email);
        newUser.setUserName(username);
        newUser.setFullName(fullname);
        newUser.setPassWord(hashedPassword);
        newUser.setAvatar("avata.png");
        newUser.setRoleid(5); // Quyền khách hàng
        newUser.setPhone(phone);
        newUser.setCreatedDate(date);
        newUser.setStatus(0); // 0: Chờ kích hoạt tài khoản bằng OTP
        newUser.setCode(otp);
        newUser.setCodeTime(now);

        userDao.insert(newUser);

        // Gửi email OTP kích hoạt tài khoản
        String subject = "Xác nhận kích hoạt tài khoản - ShoppingService MVC";
        String body = "<div style='font-family: Arial, sans-serif; line-height: 1.6;'>"
                + "<h2 style='color: #2c3e50;'>KÍCH HOẠT TÀI KHOẢN</h2>"
                + "<p>Xin chào <b>" + fullname + "</b>,</p>"
                + "<p>Cảm ơn bạn đã đăng ký tài khoản tại ShoppingService MVC. Mã OTP kích hoạt của bạn là:</p>"
                + "<div style='font-size: 28px; font-weight: bold; color: #0d6efd; background: #e7f1ff; display: inline-block; padding: 10px 24px; border-radius: 8px; letter-spacing: 6px;'>"
                + otp + "</div>"
                + "<p style='margin-top: 15px;'>Mã có hiệu lực trong vòng 10 phút. Vui lòng không chia sẻ mã này cho người khác.</p>"
                + "</div>";
        EmailUtil.sendEmail(email, subject, body);

        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            user = userDao.get(email);
        }
        if (user != null && otp != null && otp.trim().equals(user.getCode())) {
            userDao.activateUser(user.getEmail());
            return true;
        }
        return false;
    }

    @Override
    public boolean forgotPassword(String email) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }

        // Sinh mã OTP 6 số
        String otp = String.format("%06d", new Random().nextInt(999999));
        userDao.updateCode(email, otp);

        // Gửi email OTP đặt lại mật khẩu
        String subject = "Mã xác nhận đặt lại mật khẩu - ShoppingService MVC";
        String body = "<div style='font-family: Arial, sans-serif; line-height: 1.6;'>"
                + "<h2 style='color: #e74c3c;'>YÊU CẦU ĐẶT LẠI MẬT KHẨU</h2>"
                + "<p>Xin chào <b>" + user.getFullName() + "</b>,</p>"
                + "<p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản <b>" + user.getUserName() + "</b>.</p>"
                + "<p>Mã OTP xác thực của bạn là:</p>"
                + "<div style='font-size: 28px; font-weight: bold; color: #dc3545; background: #ffebee; display: inline-block; padding: 10px 24px; border-radius: 8px; letter-spacing: 6px;'>"
                + otp + "</div>"
                + "<p style='margin-top: 15px;'>Nếu bạn không thực hiện yêu cầu này, vui lòng bỏ qua email.</p>"
                + "</div>";
        EmailUtil.sendEmail(email, subject, body);

        return true;
    }

    @Override
    public boolean resetPassword(String email, String otp, String newPassword) {
        User user = userDao.findByEmail(email);
        if (user != null && otp != null && otp.trim().equals(user.getCode())) {
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(10));
            userDao.updatePassword(email, hashedPassword);
            return true;
        }
        return false;
    }
}
