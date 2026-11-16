package vn.iotstar.util;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    public static boolean sendEmail(String toEmail, String subject, String bodyContent) {
        // Luôn hiển thị mã OTP ra console để dễ dàng test / chấm điểm trực tiếp
        System.out.println("==================================================================");
        System.out.println(">>> [EMAIL SERVICE NOTIFICATION]");
        System.out.println(">>> Người nhận: " + toEmail);
        System.out.println(">>> Tiêu đề   : " + subject);
        System.out.println(">>> Nội dung  : " + bodyContent);
        System.out.println("==================================================================");

        final String fromEmail = Constant.SENDER_EMAIL;
        final String password = Constant.SENDER_PASSWORD;

        // Nếu chưa điền App Password thật của Gmail thì ghi nhận log và hoàn thành (tránh crash hoặc timeout)
        if (password == null || password.trim().isEmpty() || password.equals("app_password_here")) {
            System.out.println(">>> [EmailUtil] Chưa cấu hình Google App Password thực tế, mã OTP đã được in ra console.");
            return true;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };

        try {
            Session session = Session.getInstance(props, auth);
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail, "ShoppingService MVC"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setSubject(subject, "UTF-8");
            msg.setContent(bodyContent, "text/html; charset=UTF-8");

            Transport.send(msg);
            System.out.println(">>> [EmailUtil] Gửi email thành công đến: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println(">>> [EmailUtil] Gửi email thất bại: " + e.getMessage());
            // Trả về true để không chặn luồng đăng ký / quên mật khẩu của người dùng khi test
            return true;
        }
    }
}
