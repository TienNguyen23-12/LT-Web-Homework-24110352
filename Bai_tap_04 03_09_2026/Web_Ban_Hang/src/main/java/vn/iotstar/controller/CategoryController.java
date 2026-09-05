package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.CategoryServiceImpl;
import vn.iotstar.utils.ValidationUtils;

import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/categories", "/admin/category/add", "/admin/category/insert", "/admin/category/edit", "/admin/category/update", "/admin/category/delete"})
public class CategoryController extends HttpServlet {
    private ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.endsWith("/admin/categories")) {
            int page = 0;
            if (req.getParameter("page") != null) {
                try {
                    page = Math.max(0, Integer.parseInt(req.getParameter("page")));
                } catch (NumberFormatException e) {
                    page = 0;
                }
            }
            int pageSize = 10;
            if (req.getParameter("size") != null) {
                try {
                    pageSize = Math.max(1, Integer.parseInt(req.getParameter("size")));
                } catch (NumberFormatException e) {
                    pageSize = 10;
                }
            }
            String keyword = req.getParameter("keyword");
            int count = categoryService.count(keyword);
            int totalPages = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);

            req.setAttribute("listCategory", categoryService.findAllWithPagination(page, pageSize, keyword));
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentSize", pageSize);
            req.setAttribute("keyword", keyword);
            req.getRequestDispatcher("/views/admin/category-list.jsp").include(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").include(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Category c = categoryService.findById(id);
                if (c == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/categories?error=notfound");
                    return;
                }
                req.setAttribute("c", c);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").include(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
            }
        } else if (url.contains("/admin/category/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                categoryService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/category/insert")) {
            String name = req.getParameter("categoryname");

            // Server-side validation
            if (!ValidationUtils.isNotBlank(name)) {
                req.setAttribute("error", "Tên danh mục không được để trống hoặc chỉ chứa khoảng trắng!");
                req.setAttribute("categoryname", name);
                req.getRequestDispatcher("/views/admin/category-add.jsp").include(req, resp);
                return;
            }

            name = name.trim();
            if (name.length() < 2 || name.length() > 100) {
                req.setAttribute("error", "Tên danh mục phải có độ dài từ 2 đến 100 ký tự!");
                req.setAttribute("categoryname", name);
                req.getRequestDispatcher("/views/admin/category-add.jsp").include(req, resp);
                return;
            }

            try {
                Category c = new Category();
                c.setCategoryname(name);
                c.setStatus(1);
                categoryService.insert(c);
                resp.sendRedirect(req.getContextPath() + "/admin/categories?message=add_success");
            } catch (Exception e) {
                req.setAttribute("error", "Không thể thêm danh mục: " + e.getMessage());
                req.setAttribute("categoryname", name);
                req.getRequestDispatcher("/views/admin/category-add.jsp").include(req, resp);
            }

        } else if (url.contains("/admin/category/update")) {
            String idStr = req.getParameter("categoryId");
            String name = req.getParameter("categoryname");

            if (!ValidationUtils.isPositiveInteger(idStr)) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }

            int id = Integer.parseInt(idStr);
            Category c = categoryService.findById(id);
            if (c == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }

            // Server-side validation
            if (!ValidationUtils.isNotBlank(name)) {
                req.setAttribute("error", "Tên danh mục không được để trống hoặc chỉ chứa khoảng trắng!");
                c.setCategoryname(name);
                req.setAttribute("c", c);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").include(req, resp);
                return;
            }

            name = name.trim();
            if (name.length() < 2 || name.length() > 100) {
                req.setAttribute("error", "Tên danh mục phải có độ dài từ 2 đến 100 ký tự!");
                c.setCategoryname(name);
                req.setAttribute("c", c);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").include(req, resp);
                return;
            }

            try {
                c.setCategoryname(name);
                categoryService.update(c);
                resp.sendRedirect(req.getContextPath() + "/admin/categories?message=update_success");
            } catch (Exception e) {
                req.setAttribute("error", "Không thể cập nhật danh mục: " + e.getMessage());
                req.setAttribute("c", c);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").include(req, resp);
            }
        }
    }
}
