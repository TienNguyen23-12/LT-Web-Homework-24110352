<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><sitemesh:write property='title'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <jsp:include page="/views/common/topbar.jsp"></jsp:include>

    <div class="container-fluid mt-4 mb-5">
        <div class="row">
            <div class="col-md-2">
                <div class="list-group">
                    <a href="<c:url value='/admin/categories'/>" class="list-group-item list-group-item-action">QL Danh Mục</a>
                    <a href="<c:url value='/admin/products'/>" class="list-group-item list-group-item-action">QL Sản Phẩm</a>
                </div>
            </div>
            <div class="col-md-10">
                <sitemesh:write property='body'/>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>