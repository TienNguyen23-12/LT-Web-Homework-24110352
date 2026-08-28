package vn.iotstar.utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtils {
    private static final String FROM_EMAIL = "nguyenthanhtien2312@gmail.com";
    private static final String PASSWORD = "ecna twxk wlfj hptd";

    public static boolean sendEmail (String toEmail, String subject, String body) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        };

        Session session = Session.getInstance(props, auth);
        try {
            MimeMessage msg = new MimeMessage(session);
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(new InternetAddress(FROM_EMAIL, "Shopping System"));
            msg.setSubject(subject, "UTF-8");
            msg.setText(body, "UTF-8");
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            Transport.send(msg);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
