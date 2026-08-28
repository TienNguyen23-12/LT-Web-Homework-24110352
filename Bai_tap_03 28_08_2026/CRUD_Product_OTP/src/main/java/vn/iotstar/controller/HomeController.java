package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.ProductServiceImpl;
import java.io.IOException;

@WebServlet(urlPatterns = {"/home", "/product", "/product/detail"})
public class HomeController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/home")) {
            req.setAttribute("top10", productService.findTop10Newest());
            req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
        }
        else if (url.endsWith("/product")) {
            int page = 0;
            if (req.getParameter("page") != null) {
                page = Integer.parseInt(req.getParameter("page"));
            }

            String keyword = req.getParameter("keyword");
            int count = productService.count(keyword);
            int pageSize = 6;
            int totalPages = (count / pageSize) + (count % pageSize == 0 ? 0 : 1);

            req.setAttribute("listproduct", productService.findAllWithPagination(page, pageSize, keyword));
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("keyword", keyword);
            req.getRequestDispatcher("/views/web/product.jsp").forward(req, resp);
        }
        else if (url.contains("/product/detail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("p", productService.findById(id));
            req.getRequestDispatcher("/views/web/detail.jsp").forward(req, resp);
        }
    }
}