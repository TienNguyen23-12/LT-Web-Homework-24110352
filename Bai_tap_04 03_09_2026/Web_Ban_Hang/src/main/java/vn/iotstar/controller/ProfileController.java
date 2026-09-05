package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.UserServiceImpl;
import vn.iotstar.utils.Constants;
import vn.iotstar.utils.ValidationUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(urlPatterns = "/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 1024 * 1024 * 5,        // 5MB
    maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class ProfileController extends HttpServlet {
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User sessionUser = (User) req.getSession().getAttribute("user");
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = userService.findByEmail(sessionUser.getEmail());
        if (user != null) {
            req.getSession().setAttribute("user", user);
            req.setAttribute("user", user);
        } else {
            req.setAttribute("user", sessionUser);
        }

        req.getRequestDispatcher("/views/web/profile.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User sessionUser = (User) req.getSession().getAttribute("user");
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = userService.findByEmail(sessionUser.getEmail());
        if (user == null) {
            user = sessionUser;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // 1. Validate Fullname
        if (!ValidationUtils.isNotBlank(fullname)) {
            user.setFullname(fullname);
            user.setPhone(phone);
            req.setAttribute("user", user);
            req.setAttribute("error", "Họ và tên không được để trống!");
            req.getRequestDispatcher("/views/web/profile.jsp").include(req, resp);
            return;
        }
        fullname = fullname.trim();
        if (fullname.length() < 2 || fullname.length() > 100) {
            user.setFullname(fullname);
            user.setPhone(phone);
            req.setAttribute("user", user);
            req.setAttribute("error", "Họ và tên phải có từ 2 đến 100 ký tự!");
            req.getRequestDispatcher("/views/web/profile.jsp").include(req, resp);
            return;
        }

        // 2. Validate Phone 
        if (ValidationUtils.isNotBlank(phone)) {
            phone = phone.trim().replaceAll("[\\s.-]", "");
            if (!ValidationUtils.isValidPhone(phone)) {
                user.setFullname(fullname);
                user.setPhone(phone);
                req.setAttribute("user", user);
                req.setAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập số điện thoại Việt Nam gồm 10 chữ số (bắt đầu bằng 03, 05, 07, 08, 09).");
                req.getRequestDispatcher("/views/web/profile.jsp").include(req, resp);
                return;
            }
        } else {
            phone = null;
        }

        // 3. Validate and upload avatar image
        Part part = null;
        try {
            part = req.getPart("imageFile");
        } catch (Exception e) {
            user.setFullname(fullname);
            user.setPhone(phone);
            req.setAttribute("user", user);
            req.setAttribute("error", "File tải lên bị lỗi hoặc dung lượng vượt quá 5MB!");
            req.getRequestDispatcher("/views/web/profile.jsp").include(req, resp);
            return;
        }

        if (part != null && part.getSize() > 0) {
            String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            if (!ValidationUtils.isValidImageExtension(submittedFileName)) {
                user.setFullname(fullname);
                user.setPhone(phone);
                req.setAttribute("user", user);
                req.setAttribute("error", "Định dạng file không được hỗ trợ! Vui lòng chỉ chọn file ảnh JPG, PNG, WEBP hoặc GIF.");
                req.getRequestDispatcher("/views/web/profile.jsp").include(req, resp);
                return;
            }

            if (!ValidationUtils.isValidFileSize(part.getSize(), 1024 * 1024 * 5)) {
                user.setFullname(fullname);
                user.setPhone(phone);
                req.setAttribute("user", user);
                req.setAttribute("error", "Dung lượng ảnh đại diện không được vượt quá 5MB!");
                req.getRequestDispatcher("/views/web/profile.jsp").include(req, resp);
                return;
            }

            String ext = "";
            int idx = submittedFileName.lastIndexOf('.');
            if (idx > 0) {
                ext = submittedFileName.substring(idx);
            }
            String newFileName = System.currentTimeMillis() + ext;

            File uploadDir = new File(Constants.DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            part.write(Constants.DIR + File.separator + newFileName);
            user.setImages(newFileName);
        }

        user.setFullname(fullname);
        user.setPhone(phone);

        try {
            userService.updateProfile(user);
            req.getSession().setAttribute("user", user);
            req.setAttribute("user", user);
            req.setAttribute("message", "Cập nhật thông tin hồ sơ thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }

        req.getRequestDispatcher("/views/web/profile.jsp").include(req, resp);
    }
}