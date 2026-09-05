package vn.iotstar.utils;

import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

public class ValidationUtils {

    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
    );

    private static final Pattern VN_PHONE_PATTERN = Pattern.compile(
            "^(03|05|07|08|09)\\d{8}$"
    );

    private static final Pattern OTP_PATTERN = Pattern.compile(
            "^\\d{6}$"
    );

    private static final List<String> ALLOWED_IMAGE_EXTENSIONS = Arrays.asList(
            ".jpg", ".jpeg", ".png", ".webp", ".gif"
    );

    public static boolean isNotBlank(String str) {
        return str != null && !str.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        if (!isNotBlank(email)) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (!isNotBlank(phone)) {
            return false;
        }
        String cleanPhone = phone.trim().replaceAll("[\\s.-]", "");
        return VN_PHONE_PATTERN.matcher(cleanPhone).matches();
    }

    public static boolean isValidOtp(String otp) {
        if (!isNotBlank(otp)) {
            return false;
        }
        return OTP_PATTERN.matcher(otp.trim()).matches();
    }

    public static boolean isPositiveInteger(String str) {
        if (!isNotBlank(str)) {
            return false;
        }
        try {
            int val = Integer.parseInt(str.trim());
            return val > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isNonNegativeInteger(String str) {
        if (!isNotBlank(str)) {
            return false;
        }
        try {
            int val = Integer.parseInt(str.trim());
            return val >= 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isValidImageExtension(String filename) {
        if (!isNotBlank(filename)) {
            return false;
        }
        String lower = filename.trim().toLowerCase();
        for (String ext : ALLOWED_IMAGE_EXTENSIONS) {
            if (lower.endsWith(ext)) {
                return true;
            }
        }
        return false;
    }

    public static boolean isValidFileSize(long sizeBytes, long maxSizeBytes) {
        return sizeBytes > 0 && sizeBytes <= maxSizeBytes;
    }
}
