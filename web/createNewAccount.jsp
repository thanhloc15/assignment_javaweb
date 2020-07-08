<%-- 
    Document   : register
    Created on : Mar 9, 2020, 10:08:08 PM
    Author     : kusmi
--%>

<%@page import="locnt.registration.RegistrationInserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <h1>Register Page</h1>
        <form action="createNewAccount" method="POST">
            <c:set var="errors" value="${requestScope.INSERTERR}" />
            Username* <input type="text" name="txtUsername" value="${param.txtUsername}" />(6 -20 chars)<br/>
            <c:if test="${not empty errors.usernameLengthErr}">
                <font color ="red">
                ${errors.usernameLengthErr} <br/>
                </font>
            </c:if>
            Password <input type="password" name="txtPassword" value="" />(6 - 30 chars)<br/>
            <c:if test="${not empty errors.passwordLengthErr}">
                <font color ="red">
                ${errors.passwordLengthErr}<br/>
                </font>
            </c:if>
            Confirm <input type="password" name="txtConfirm" value="" /><br/>
            <c:if test="${not empty errors.confirmNotMatch}">
                <font color ="red">
                ${errors.confirmNotMatch}<br/>
                </font>
            </c:if>
            Full name <input type="text" name="txtFullname" value="${param.txtFullname}" />(2 - 50 chars)<br/>
            <c:if test="${not empty errors.fullNameLengthErr}">
                <font color ="red">
                ${errors.fullNameLengthErr}<br/>
                </font>
            </c:if>
            <input type="submit" value="Create New Accout" name="btAction" />
            <input type="reset" value="Reset" />
        </form>
        <c:if test="${not empty errors.usernameIsExisted}">
            <font color ="red">
            ${errors.usernameIsExisted}
            </font>
        </c:if>
    </body>
</html>
