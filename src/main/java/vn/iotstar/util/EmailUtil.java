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

    public static boolean isSmtpConfigured() {
        String password = AppConfig.get("MAIL_SENDER_PASSWORD", "mail.sender.password", Constant.SENDER_PASSWORD);
        return password != null && !password.trim().isEmpty() && !password.equals("app_password_here");
    }

    public static boolean sendEmail(String toEmail, String subject, String bodyContent) {
        // Luôn hiển thị mã OTP ra console để thuận tiện theo dõi log server
        System.out.println("==================================================================");
        System.out.println(">>> [EMAIL SERVICE NOTIFICATION]");
        System.out.println(">>> Người nhận: " + toEmail);
        System.out.println(">>> Tiêu đề   : " + subject);
        System.out.println(">>> Nội dung  : " + bodyContent);
        System.out.println("==================================================================");

        final String fromEmail = AppConfig.get("MAIL_SENDER_EMAIL", "mail.sender.email", Constant.SENDER_EMAIL);
        final String password = AppConfig.get("MAIL_SENDER_PASSWORD", "mail.sender.password", Constant.SENDER_PASSWORD);

        // Nếu chưa cấu hình Google App Password thực tế thì hoạt động ở chế độ Dev Console
        if (password == null || password.trim().isEmpty() || password.equals("app_password_here")) {
            System.out.println(">>> [EmailUtil] Chưa cấu hình Google App Password thực tế, mã OTP đã được in ra console.");
            return true;
        }

        // Bỏ khoảng trắng nếu người dùng copy App Password dạng "xxxx xxxx xxxx xxxx"
        final String cleanPassword = password.replaceAll("\\s+", "");

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout", "10000");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, cleanPassword);
            }
        };

        try {
            Session session = Session.getInstance(props, auth);
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail, "Shopping & Video MVC"));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setSubject(subject, "UTF-8");
            msg.setContent(bodyContent, "text/html; charset=UTF-8");

            Transport.send(msg);
            System.out.println(">>> [EmailUtil] Gửi email SMTP thành công từ " + fromEmail + " đến: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println(">>> [EmailUtil] Gửi email SMTP thất bại: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
