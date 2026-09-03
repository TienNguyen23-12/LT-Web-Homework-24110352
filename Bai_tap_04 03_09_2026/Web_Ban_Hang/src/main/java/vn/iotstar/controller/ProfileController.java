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

import java.io.File;
import java.io.IOException;

@WebServlet(urlPatterns = {"/profile", "/profile/update"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class ProfileController extends HttpServlet {

    private IUserService userService = new UserServiceImpl();

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "default.jpg";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        user.setFullname(fullname);
        user.setPhone(phone);

        String uploadPath = Constants.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        Part part = req.getPart("images");
        if (part != null && part.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + getFileName(part);
            part.write(uploadPath + File.separator + fileName);
            user.setImages(fileName);
        }

        userService.updateProfile(user);
        req.getSession().setAttribute("user", user); // Update session with new info
        
        req.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }
}
