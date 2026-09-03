package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.CategoryServiceImpl;
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
                page = Integer.parseInt(req.getParameter("page"));
            }
            int pageSize = 10;
            if (req.getParameter("size") != null) {
                pageSize = Integer.parseInt(req.getParameter("size"));
            }
            String keyword = req.getParameter("keyword");
            int count = categoryService.count(keyword);
            int totalPages = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);

            req.setAttribute("listCategory", categoryService.findAllWithPagination(page, pageSize, keyword));
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentSize", pageSize);
            req.setAttribute("keyword", keyword);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category c = categoryService.findById(id);
            req.setAttribute("c", c);
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
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
            Category c = new Category();
            c.setCategoryname(req.getParameter("categoryname"));
            categoryService.insert(c);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } else if (url.contains("/admin/category/update")) {
            int id = Integer.parseInt(req.getParameter("categoryId"));
            Category c = categoryService.findById(id);
            c.setCategoryname(req.getParameter("categoryname"));
            categoryService.update(c);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }
}
