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
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.CategoryServiceImpl;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.ProductServiceImpl;
import vn.iotstar.utils.Constants;
import vn.iotstar.utils.ValidationUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;

@WebServlet(urlPatterns = {"/admin/products", "/admin/product/add", "/admin/product/insert", "/admin/product/edit", "/admin/product/update", "/admin/product/delete"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1MB
        maxFileSize = 1024 * 1024 * 5,        // 5MB
        maxRequestSize = 1024 * 1024 * 5 * 5  // 25MB
)
public class ProductController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    private String getFileName(Part part) {
        if (part == null) return null;
        String submittedFileName = part.getSubmittedFileName();
        if (submittedFileName != null) {
            return Paths.get(submittedFileName).getFileName().toString();
        }
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.endsWith("/admin/products")) {
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
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product p = productService.findById(id);
                if (p == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/products?error=notfound");
                    return;
                }
                req.setAttribute("p", p);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").include(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
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
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            String productName = req.getParameter("productName");
            String priceStr = req.getParameter("price");
            String quantityStr = req.getParameter("quantity");
            String categoryIdStr = req.getParameter("categoryId");

            // 1. Validate Product Name
            if (!ValidationUtils.isNotBlank(productName)) {
                forwardWithErrorAdd(req, resp, "Tên sản phẩm không được để trống!", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }
            productName = productName.trim();
            if (productName.length() < 2 || productName.length() > 200) {
                forwardWithErrorAdd(req, resp, "Tên sản phẩm phải có độ dài từ 2 đến 200 ký tự!", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }

            // 2. Validate Price
            if (!ValidationUtils.isPositiveInteger(priceStr)) {
                forwardWithErrorAdd(req, resp, "Giá sản phẩm phải là một số nguyên dương (> 0 VNĐ)!", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }
            int price = Integer.parseInt(priceStr.trim());

            // 3. Validate Quantity
            if (!ValidationUtils.isNonNegativeInteger(quantityStr)) {
                forwardWithErrorAdd(req, resp, "Số lượng kho phải là số nguyên không âm (>= 0)!", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }
            int quantity = Integer.parseInt(quantityStr.trim());

            // 4. Validate Category
            if (!ValidationUtils.isPositiveInteger(categoryIdStr)) {
                forwardWithErrorAdd(req, resp, "Vui lòng chọn danh mục hợp lệ!", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }
            int categoryId = Integer.parseInt(categoryIdStr.trim());
            Category category = categoryService.findById(categoryId);
            if (category == null) {
                forwardWithErrorAdd(req, resp, "Danh mục đã chọn không tồn tại trong hệ thống!", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }

            // 5. Validate Image file
            Part part = null;
            try {
                part = req.getPart("images");
            } catch (Exception e) {
                forwardWithErrorAdd(req, resp, "File ảnh không hợp lệ hoặc dung lượng vượt quá 5MB!", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }

            String fileName = getFileName(part);
            if (!ValidationUtils.isNotBlank(fileName) || part.getSize() == 0) {
                forwardWithErrorAdd(req, resp, "Vui lòng chọn hình ảnh đại diện cho sản phẩm!", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }

            if (!ValidationUtils.isValidImageExtension(fileName)) {
                forwardWithErrorAdd(req, resp, "Định dạng file không hỗ trợ! Vui lòng chỉ tải ảnh định dạng .jpg, .jpeg, .png, .webp, .gif", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }

            if (!ValidationUtils.isValidFileSize(part.getSize(), 1024 * 1024 * 5)) {
                forwardWithErrorAdd(req, resp, "Dung lượng hình ảnh không được vượt quá 5MB!", productName, priceStr, quantityStr, categoryIdStr);
                return;
            }

            // Save file
            String uploadPath = Constants.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String savedFileName = System.currentTimeMillis() + "_" + fileName;
            part.write(uploadPath + File.separator + savedFileName);

            // Persist product
            try {
                Product p = new Product();
                p.setProductName(productName);
                p.setPrice(price);
                p.setQuantity(quantity);
                p.setCategory(category);
                p.setImages(savedFileName);
                p.setCreateDate(new Date());

                productService.insert(p);
                resp.sendRedirect(req.getContextPath() + "/admin/products?message=add_success");
            } catch (Exception e) {
                forwardWithErrorAdd(req, resp, "Lỗi khi lưu sản phẩm: " + e.getMessage(), productName, priceStr, quantityStr, categoryIdStr);
            }

        } else if (url.contains("/admin/product/update")) {
            String productIdStr = req.getParameter("productId");
            String productName = req.getParameter("productName");
            String priceStr = req.getParameter("price");
            String quantityStr = req.getParameter("quantity");
            String categoryIdStr = req.getParameter("categoryId");

            if (!ValidationUtils.isPositiveInteger(productIdStr)) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            int productId = Integer.parseInt(productIdStr);
            Product p = productService.findById(productId);
            if (p == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            // 1. Validate Product Name
            if (!ValidationUtils.isNotBlank(productName)) {
                forwardWithErrorEdit(req, resp, "Tên sản phẩm không được để trống!", p, productName, priceStr, quantityStr, categoryIdStr);
                return;
            }
            productName = productName.trim();
            if (productName.length() < 2 || productName.length() > 200) {
                forwardWithErrorEdit(req, resp, "Tên sản phẩm phải có độ dài từ 2 đến 200 ký tự!", p, productName, priceStr, quantityStr, categoryIdStr);
                return;
            }

            // 2. Validate Price
            if (!ValidationUtils.isPositiveInteger(priceStr)) {
                forwardWithErrorEdit(req, resp, "Giá sản phẩm phải là một số nguyên dương (> 0 VNĐ)!", p, productName, priceStr, quantityStr, categoryIdStr);
                return;
            }
            int price = Integer.parseInt(priceStr.trim());

            // 3. Validate Quantity
            if (!ValidationUtils.isNonNegativeInteger(quantityStr)) {
                forwardWithErrorEdit(req, resp, "Số lượng kho phải là số nguyên không âm (>= 0)!", p, productName, priceStr, quantityStr, categoryIdStr);
                return;
            }
            int quantity = Integer.parseInt(quantityStr.trim());

            // 4. Validate Category
            if (!ValidationUtils.isPositiveInteger(categoryIdStr)) {
                forwardWithErrorEdit(req, resp, "Vui lòng chọn danh mục hợp lệ!", p, productName, priceStr, quantityStr, categoryIdStr);
                return;
            }
            int categoryId = Integer.parseInt(categoryIdStr.trim());
            Category category = categoryService.findById(categoryId);
            if (category == null) {
                forwardWithErrorEdit(req, resp, "Danh mục đã chọn không tồn tại trong hệ thống!", p, productName, priceStr, quantityStr, categoryIdStr);
                return;
            }

            // 5. Optional Image check
            Part part = null;
            try {
                part = req.getPart("images");
            } catch (Exception e) {
                forwardWithErrorEdit(req, resp, "File ảnh tải lên bị lỗi hoặc vượt quá 5MB!", p, productName, priceStr, quantityStr, categoryIdStr);
                return;
            }

            if (part != null && part.getSize() > 0) {
                String fileName = getFileName(part);
                if (!ValidationUtils.isValidImageExtension(fileName)) {
                    forwardWithErrorEdit(req, resp, "Định dạng file không hỗ trợ! Vui lòng chỉ tải ảnh định dạng .jpg, .jpeg, .png, .webp, .gif", p, productName, priceStr, quantityStr, categoryIdStr);
                    return;
                }
                if (!ValidationUtils.isValidFileSize(part.getSize(), 1024 * 1024 * 5)) {
                    forwardWithErrorEdit(req, resp, "Dung lượng hình ảnh không được vượt quá 5MB!", p, productName, priceStr, quantityStr, categoryIdStr);
                    return;
                }

                String uploadPath = Constants.DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String savedFileName = System.currentTimeMillis() + "_" + fileName;
                part.write(uploadPath + File.separator + savedFileName);
                p.setImages(savedFileName);
            }

            try {
                p.setProductName(productName);
                p.setPrice(price);
                p.setQuantity(quantity);
                p.setCategory(category);

                productService.update(p);
                resp.sendRedirect(req.getContextPath() + "/admin/products?message=update_success");
            } catch (Exception e) {
                forwardWithErrorEdit(req, resp, "Lỗi khi cập nhật sản phẩm: " + e.getMessage(), p, productName, priceStr, quantityStr, categoryIdStr);
            }
        }
    }

    private void forwardWithErrorAdd(HttpServletRequest req, HttpServletResponse resp, String error,
                                     String productName, String price, String quantity, String categoryId)
            throws ServletException, IOException {
        req.setAttribute("error", error);
        req.setAttribute("productName", productName);
        req.setAttribute("price", price);
        req.setAttribute("quantity", quantity);
        req.setAttribute("selectedCategoryId", categoryId);
        req.setAttribute("categories", categoryService.findAll());
        req.getRequestDispatcher("/views/admin/product-add.jsp").include(req, resp);
    }

    private void forwardWithErrorEdit(HttpServletRequest req, HttpServletResponse resp, String error,
                                      Product p, String productName, String price, String quantity, String categoryId)
            throws ServletException, IOException {
        req.setAttribute("error", error);
        p.setProductName(productName);
        try { if (ValidationUtils.isPositiveInteger(price)) p.setPrice(Integer.parseInt(price)); } catch (Exception ignored) {}
        try { if (ValidationUtils.isNonNegativeInteger(quantity)) p.setQuantity(Integer.parseInt(quantity)); } catch (Exception ignored) {}
        if (ValidationUtils.isPositiveInteger(categoryId)) {
            Category c = categoryService.findById(Integer.parseInt(categoryId));
            if (c != null) p.setCategory(c);
        }
        req.setAttribute("p", p);
        req.setAttribute("categories", categoryService.findAll());
        req.getRequestDispatcher("/views/admin/product-edit.jsp").include(req, resp);
    }
}