<%--
  Created by IntelliJ IDEA.
  User: Thanh Tien
  Date: 8/26/2026
  Time: 8:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
    <c:when test="${sessionScope.account == null}">
        <ul class="list-inline" style="margin: 0; padding: 10px 0;">
            <li>
                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> |
                <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
            </li>
            <li><i class="search fa fa-search search-button"></i></li>
        </ul>
    </c:when>
    <c:otherwise>
        <ul class="list-inline" style="margin: 0; padding: 10px 0;">
            <li>
                <p style="display: inline; margin: 0;">${sessionScope.account.fullName}</p> |
                <a href="${pageContext.request.contextPath}/logout">Đăng Xuất</a>
            </li>
            <li><i class="search fa fa-search search-button"></i></li>
        </ul>
    </c:otherwise>
</c:choose>

