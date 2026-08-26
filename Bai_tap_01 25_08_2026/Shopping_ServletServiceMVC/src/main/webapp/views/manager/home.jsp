<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 8/26/2026
  Time: 7:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Quản Lý - Manager</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f9f9f9; }
        .top-nav { background-color: #fff; padding: 15px 0; border-bottom: 1px solid #e0e0e0; margin-bottom: 30px; }
        .brand-logo { font-size: 18px; font-weight: bold; color: #009be3; text-decoration: none; }
        .brand-logo:hover { color: #007bb5; text-decoration: none; }
        .main-content { background-color: #fff; padding: 40px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<div class="top-nav">
    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <a href="${pageContext.request.contextPath}/home" class="brand-logo">Shopping App</a>
            </div>
            <div class="col-sm-6 text-right">
                <jsp:include page="/common/topbar.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="main-content text-center">
        <h2>Xin chào Manager: <strong>${sessionScope.account.fullName}</strong></h2>
        <p class="text-muted">Khu vực dành cho Quản lý</p>
        <br>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger"><i class="fa fa-sign-out"></i> Đăng xuất</a>
    </div>
</div>

</body>
</html>
