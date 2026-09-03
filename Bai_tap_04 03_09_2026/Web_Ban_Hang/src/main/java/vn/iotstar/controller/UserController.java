package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.UserServiceImpl;
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
        String url = req.getRequestURI();

        if (url.contains("/register")) {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String fullname = req.getParameter("fullname");

            if (userService.register(email, password, fullname)) {
                req.getSession().setAttribute("email", email);
                resp.sendRedirect(req.getContextPath() + "/verify-otp");
            } else {
                req.setAttribute("error", "Email này đã được sử dụng! Vui lòng chọn email khác.");
                req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            }
        }
        else if (url.contains("/verify-otp")) {
            String email = (String) req.getSession().getAttribute("email");
            String otp = req.getParameter("otp");

            if (userService.verifyOtp(email, otp)) {
                resp.sendRedirect(req.getContextPath() + "/login?message=active_success");
            } else {
                req.setAttribute("error", "Mã xác thực OTP không chính xác, vui lòng thử lại!");
                req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
            }
        }
        else if (url.contains("/login")) {
            String email = req.getParameter("email");
            String pass = req.getParameter("password");

            User user = userService.login(email, pass);
            if (user != null) {
                req.getSession().setAttribute("user", user);
                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                req.setAttribute("error", "Thông tin đăng nhập không đúng hoặc tài khoản chưa được kích hoạt!");
                req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            }
        }
        else if (url.contains("/forgot-password")) {
            String email = req.getParameter("email");

            if (userService.sendForgotPasswordOtp(email)) {
                req.getSession().setAttribute("reset_email", email);
                resp.sendRedirect(req.getContextPath() + "/reset-password");
            } else {
                req.setAttribute("error", "Không tìm thấy email này trong hệ thống!");
                req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            }
        }
        else if (url.contains("/reset-password")) {
            String email = (String) req.getSession().getAttribute("reset_email");
            String otp = req.getParameter("otp");
            String newPassword = req.getParameter("new_password");

            if (userService.verifyOtp(email, otp)) {
                userService.resetPassword(email, newPassword);
                resp.sendRedirect(req.getContextPath() + "/login?message=reset_success");
            } else {
                req.setAttribute("error", "Mã xác thực OTP không chính xác, vui lòng thử lại!");
                req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
            }
        }
    }
}