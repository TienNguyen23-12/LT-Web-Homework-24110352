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
import java.nio.file.Paths;

@WebServlet(urlPatterns = "/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
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

        user.setFullname(fullname);
        user.setPhone(phone);

        try {
            Part part = req.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
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
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            userService.updateProfile(user);
            req.getSession().setAttribute("user", user);
            req.setAttribute("user", user);
            req.setAttribute("message", "Cập nhật thông tin thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
        }

        req.getRequestDispatcher("/views/web/profile.jsp").include(req, resp);
    }
}