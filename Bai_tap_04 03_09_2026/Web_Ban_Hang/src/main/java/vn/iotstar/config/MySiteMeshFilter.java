package vn.iotstar.config;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.content.Content;
import org.sitemesh.webapp.SiteMeshFilter;
import org.sitemesh.webapp.WebAppContext;
import org.sitemesh.webapp.contentfilter.ResponseMetaData;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;

public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        System.err.println(">>> [DEBUG SITEMESH] doFilter start: " + ((HttpServletRequest) request).getRequestURI());
        if (response.getContentType() == null) {
            response.setContentType("text/html; charset=UTF-8");
        }
        super.doFilter(request, response, chain);
        System.err.println(">>> [DEBUG SITEMESH] doFilter end: " + ((HttpServletRequest) request).getRequestURI());
    }

    @Override
    protected Filter setup() throws ServletException {
        System.err.println(">>> [DEBUG SITEMESH] setup() called!");
        SiteMeshFilterBuilder builder = new SiteMeshFilterBuilder();
        builder.setDecoratorPrefix("")
               .addDecoratorPath("/admin/*", "/views/common/admin.jsp")
               .addDecoratorPath("/*", "/views/common/web.jsp")
               .addExcludedPath("/login*")
               .addExcludedPath("/register*")
               .addExcludedPath("/verify-otp*")
               .addExcludedPath("/forgot-password*")
               .addExcludedPath("/reset-password*")
               .addExcludedPath("/image*")
               .addExcludedPath("/upload*")
               .addExcludedPath("/assets/*")
               .addExcludedPath("/views/*");

        return new SiteMeshFilter(builder.getSelector(), builder.getContentProcessor(),
                builder.getDecoratorSelector(), builder.isIncludeErrorPages()) {
            @Override
            protected boolean postProcess(String contentType, java.nio.CharBuffer buffer,
                    HttpServletRequest request, HttpServletResponse response,
                    ResponseMetaData responseMetaData) throws IOException, ServletException {
                System.err.println(">>> [DEBUG SITEMESH] postProcess called! buffer length = " + (buffer != null ? buffer.length() : "null"));
                boolean res = super.postProcess(contentType, buffer, request, response, responseMetaData);
                System.err.println(">>> [DEBUG SITEMESH] postProcess result: " + res);
                return res;
            }

            @Override
            protected WebAppContext createContext(String contentType, HttpServletRequest request,
                    HttpServletResponse response, ResponseMetaData responseMetaData) {
                return new WebAppContext(contentType, request, response,
                        getFilterConfig().getServletContext(), getContentProcessor(),
                        responseMetaData, builder.isIncludeErrorPages()) {
                    @Override
                    protected void decorate(String decoratorPath, Content content, Writer out) throws IOException {
                        System.err.println(">>> [DEBUG SITEMESH] decorate called! decoratorPath = " + decoratorPath);
                        final CharArrayWriter charWriter = new CharArrayWriter();
                        final PrintWriter printWriter = new PrintWriter(charWriter);

                        HttpServletResponseWrapper responseWrapper =
                                new HttpServletResponseWrapper(getResponse()) {
                            @Override
                            public PrintWriter getWriter() {
                                return printWriter;
                            }

                            @Override
                            public ServletOutputStream getOutputStream() {
                                return new ServletOutputStream() {
                                    @Override
                                    public boolean isReady() { return true; }
                                    @Override
                                    public void setWriteListener(WriteListener writeListener) {}
                                    @Override
                                    public void write(int b) throws IOException {
                                        charWriter.write(b);
                                    }
                                    @Override
                                    public void write(byte[] b, int off, int len) throws IOException {
                                        charWriter.write(new String(b, off, len, StandardCharsets.UTF_8));
                                    }
                                };
                            }

                            @Override
                            public void setContentLength(int len) {}
                            @Override
                            public void setContentLengthLong(long len) {}
                        };

                        getRequest().setAttribute(CONTENT_KEY, content);
                        getRequest().setAttribute(CONTEXT_KEY, this);

                        try {
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(decoratorPath);
                            if (dispatcher == null) {
                                throw new ServletException("Could not get RequestDispatcher for " + decoratorPath);
                            }
                            dispatcher.include(getRequest(), responseWrapper);
                        } catch (Exception e) {
                            throw new IOException("Failed to dispatch to decorator: " + decoratorPath, e);
                        }

                        printWriter.flush();
                        char[] chars = charWriter.toCharArray();
                        System.err.println(">>> [DEBUG SITEMESH] captured chars length = " + chars.length);
                        out.write(chars);
                        System.err.println(">>> [DEBUG SITEMESH] decorate completed!");
                    }
                };
            }
        };
    }

    @Override
    protected boolean reloadRequired() {
        return false;
    }

    @Override
    protected boolean getAutoReload() {
        return false;
    }
}