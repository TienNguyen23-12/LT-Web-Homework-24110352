package vn.iotstar.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import java.io.IOException;

public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.setDecoratorPrefix("")
               .addDecoratorPath("/admin/*", "/views/common/admin.jsp")
               .addDecoratorPath("/*", "/views/common/web.jsp")
               .addExcludedPath("/login*")
               .addExcludedPath("/register*")
               .addExcludedPath("/verify-otp*")
               .addExcludedPath("/forgot-password*")
               .addExcludedPath("/reset-password*")
               .addExcludedPath("/image*")
               .addExcludedPath("/views/*");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        super.doFilter(request, response, chain);
        try {
            response.getWriter().flush();
        } catch (Exception e) {
            try {
                response.getOutputStream().flush();
            } catch (Exception ignored) {}
        }
    }
}
