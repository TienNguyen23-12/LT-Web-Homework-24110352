package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/home", "/admin/home", "/manager/home"})
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/home".equals(path)) {
            req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
        } else if ("/manager/home".equals(path)) {
            req.getRequestDispatcher("/views/manager/home.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
        }
    }
}