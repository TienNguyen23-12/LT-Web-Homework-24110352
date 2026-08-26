<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 8/25/2026
  Time: 4:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #fff;
            font-family: Arial, sans-serif;
        }
        .top-nav { background-color: #fff; padding: 10px 0; border-bottom: 1px solid #e0e0e0; }
        .login-container {
            max-width: 400px;
            margin: 60px auto;
            padding: 20px;
            border: 1px solid #e0e0e0;
        }
        .login-container h3 {
            text-align: center;
            color: #888;
            margin-bottom: 25px;
            font-size: 20px;
        }
        .form-section {
            margin-bottom: 15px;
        }
        .input-group-addon {
            background-color: #f5f5f5;
            color: #888;
        }
        .form-control {
            background-color: #f9f9f9;
        }
        .options-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            font-size: 13px;
            color: #666;
        }
        .options-row a {
            color: #666;
            text-decoration: underline;
        }
        .btn-login {
            background-color: #009be3;
            color: white;
            border: none;
        }
        .btn-login:hover {
            background-color: #007bb5;
            color: white;
        }
        .footer-text {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: #888;
        }
        .footer-text a {
            color: #009be3;
        }
    </style>
</head>
<body>

<div class="top-nav">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 text-center">
                <jsp:include page="/common/topbar.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>

<div class="login-container">
    <form action="${pageContext.request.contextPath}/login" method="post">
        <h3>Đăng Nhập Vào Hệ Thống</h3>
        
        <c:if test="${alert != null}">
            <div class="alert alert-danger" style="padding: 10px; margin-bottom: 15px; text-align: center;">${alert}</div>
        </c:if>
        
        <section class="form-section">
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                <input type="text" placeholder="Tài khoản" name="username" class="form-control" required>
            </div>
        </section>
        
        <section class="form-section">
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                <input type="password" placeholder="Mật khẩu" name="password" class="form-control" required>
            </div>
        </section>
        
        <section class="options-row">
            <label style="font-weight: normal; margin: 0;">
                <input type="checkbox" name="remember"> Nhớ tôi
            </label>
            <a href="#">Quên mật khẩu?</a>
        </section>
        
        <button class="btn btn-login btn-block" type="submit">Đăng nhập</button>
    </form>
    
    <div class="footer-text">
        Nếu bạn chưa có tài khoản trên hệ thống, thì hãy <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
    </div>
</div>

</body>
</html>