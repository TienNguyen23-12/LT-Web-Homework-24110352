package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Product;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.ProductServiceImpl;
import vn.iotstar.utils.Constants;
import java.io.File;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/products", "/admin/product/add", "/admin/product/insert", "/admin/product/edit", "/admin/product/update", "/admin/product/delete"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class ProductController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();
    private vn.iotstar.service.ICategoryService categoryService = new vn.iotstar.service.CategoryServiceImpl();

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
        String url = req.getRequestURI();

        if (url.endsWith("/admin/products")) {
            int page = 0;
            if (req.getParameter("page") != null) {
                page = Integer.parseInt(req.getParameter("page"));
            }
            int pageSize = 10;
            if (req.getParameter("size") != null) {
                pageSize = Integer.parseInt(req.getParameter("size"));
            }
            String keyword = req.getParameter("keyword");
            int count = productService.count(keyword);
            int totalPages = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);

            req.setAttribute("listproduct", productService.findAllWithPagination(page, pageSize, keyword));
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentSize", pageSize);
            req.setAttribute("keyword", keyword);
            req.getRequestDispatcher("/views/admin/product-list.jsp").include(req, resp);
        } else if (url.contains("/admin/product/add")) {
            req.setAttribute("categories", categoryService.findAll());
            req.getRequestDispatcher("/views/admin/product-add.jsp").include(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product p = productService.findById(id);
            req.setAttribute("p", p);
            req.setAttribute("categories", categoryService.findAll());
            req.getRequestDispatcher("/views/admin/product-edit.jsp").include(req, resp);
        } else if (url.contains("/admin/product/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            Product p = new Product();
            p.setProductName(req.getParameter("productName"));
            p.setPrice(Integer.parseInt(req.getParameter("price")));
            p.setQuantity(Integer.parseInt(req.getParameter("quantity")));

            Category c = new Category();
            c.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            p.setCategory(c);

            String uploadPath = Constants.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            Part part = req.getPart("images");
            if (part != null && part.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + getFileName(part);
                part.write(uploadPath + File.separator + fileName);
                p.setImages(fileName);
            } else {
                p.setImages("default.jpg");
            }

            productService.insert(p);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if (url.contains("/admin/product/update")) {
            int id = Integer.parseInt(req.getParameter("productId"));
            Product p = productService.findById(id);
            p.setProductName(req.getParameter("productName"));
            p.setPrice(Integer.parseInt(req.getParameter("price")));
            p.setQuantity(Integer.parseInt(req.getParameter("quantity")));

            Category c = new Category();
            c.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
            p.setCategory(c);

            String uploadPath = Constants.DIR;
            Part part = req.getPart("images");
            if (part != null && part.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + getFileName(part);
                part.write(uploadPath + File.separator + fileName);
                p.setImages(fileName);
            }

            productService.update(p);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}