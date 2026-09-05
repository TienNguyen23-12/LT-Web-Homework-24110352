package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.UserServiceImpl;
import vn.iotstar.utils.ValidationUtils;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/verify-otp", "/forgot-password", "/reset-password"})
public class UserController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/login")) {
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        } else if (url.contains("/register")) {
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        } else if (url.contains("/verify-otp")) {
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
        } else if (url.contains("/forgot-password")) {
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
        } else if (url.contains("/reset-password")) {
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/register")) {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirm_password");
            String fullname = req.getParameter("fullname");

            // 1. Validate Fullname
            if (!ValidationUtils.isNotBlank(fullname) || fullname.trim().length() < 2 || fullname.trim().length() > 100) {
                req.setAttribute("error", "Họ tên không được để trống và phải có từ 2 đến 100 ký tự!");
                retainAuthData(req, email, fullname);
                req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
                return;
            }

            // 2. Validate Email
            if (!ValidationUtils.isValidEmail(email)) {
                req.setAttribute("error", "Địa chỉ email không hợp lệ!");
                retainAuthData(req, email, fullname);
                req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
                return;
            }

            // 3. Validate Password
            if (!ValidationUtils.isNotBlank(password) || password.length() < 6) {
                req.setAttribute("error", "Mật khẩu phải có tối thiểu 6 ký tự!");
                retainAuthData(req, email, fullname);
                req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
                return;
            }

            // 4. Validate Confirm Password (if provided in form)
            if (confirmPassword != null && !password.equals(confirmPassword)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp với mật khẩu!");
                retainAuthData(req, email, fullname);
                req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
                return;
            }

            if (userService.register(email.trim(), password, fullname.trim())) {
                req.getSession().setAttribute("email", email.trim());
                resp.sendRedirect(req.getContextPath() + "/verify-otp");
            } else {
                req.setAttribute("error", "Email này đã được sử dụng! Vui lòng chọn email khác.");
                retainAuthData(req, email, fullname);
                req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            }
        }
        else if (url.contains("/verify-otp")) {
            String email = (String) req.getSession().getAttribute("email");
            String otp = req.getParameter("otp");

            if (!ValidationUtils.isNotBlank(email)) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            if (!ValidationUtils.isValidOtp(otp)) {
                req.setAttribute("error", "Mã OTP phải bao gồm đúng 6 chữ số!");
                req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
                return;
            }

            if (userService.verifyOtp(email, otp.trim())) {
                resp.sendRedirect(req.getContextPath() + "/login?message=active_success");
            } else {
                req.setAttribute("error", "Mã xác thực OTP không chính xác hoặc đã hết hạn, vui lòng thử lại!");
                req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
            }
        }
        else if (url.contains("/login")) {
            String email = req.getParameter("email");
            String pass = req.getParameter("password");

            if (!ValidationUtils.isValidEmail(email)) {
                req.setAttribute("error", "Vui lòng nhập định dạng email hợp lệ!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
                return;
            }

            if (!ValidationUtils.isNotBlank(pass)) {
                req.setAttribute("error", "Vui lòng nhập mật khẩu!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
                return;
            }

            User user = userService.login(email.trim(), pass);
            if (user != null) {
                req.getSession().setAttribute("user", user);
                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                req.setAttribute("error", "Thông tin đăng nhập không đúng hoặc tài khoản chưa được kích hoạt OTP!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            }
        }
        else if (url.contains("/forgot-password")) {
            String email = req.getParameter("email");

            if (!ValidationUtils.isValidEmail(email)) {
                req.setAttribute("error", "Vui lòng nhập đúng định dạng email đã đăng ký!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
                return;
            }

            if (userService.sendForgotPasswordOtp(email.trim())) {
                req.getSession().setAttribute("reset_email", email.trim());
                resp.sendRedirect(req.getContextPath() + "/reset-password");
            } else {
                req.setAttribute("error", "Không tìm thấy tài khoản tương ứng với email này trong hệ thống!");
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            }
        }
        else if (url.contains("/reset-password")) {
            String email = (String) req.getSession().getAttribute("reset_email");
            String otp = req.getParameter("otp");
            String newPassword = req.getParameter("new_password");
            String confirmPassword = req.getParameter("confirm_password");

            if (!ValidationUtils.isNotBlank(email)) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
                return;
            }

            if (!ValidationUtils.isValidOtp(otp)) {
                req.setAttribute("error", "Mã OTP phải bao gồm đúng 6 chữ số!");
                req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
                return;
            }

            if (!ValidationUtils.isNotBlank(newPassword) || newPassword.length() < 6) {
                req.setAttribute("error", "Mật khẩu mới phải có tối thiểu 6 ký tự!");
                req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
                return;
            }

            if (confirmPassword != null && !newPassword.equals(confirmPassword)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp với mật khẩu mới!");
                req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
                return;
            }

            if (userService.verifyOtp(email, otp.trim())) {
                userService.resetPassword(email, newPassword);
                resp.sendRedirect(req.getContextPath() + "/login?message=reset_success");
            } else {
                req.setAttribute("error", "Mã xác thực OTP không chính xác, vui lòng thử lại!");
                req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
            }
        }
    }

    private void retainAuthData(HttpServletRequest req, String email, String fullname) {
        req.setAttribute("email", email);
        req.setAttribute("fullname", fullname);
    }
}