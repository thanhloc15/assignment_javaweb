<%-- 
    Document   : superMarket
    Created on : Mar 18, 2020, 6:08:44 PM
    Author     : kusmi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Super Market</title>
    </head>
    <body>
        <h1>Book Store</h1>
        <form action="cart">
            Choose your favorite book 
            <select name="cboBook">
                <c:forEach var="list" items="${requestScope.LISTPRODUCT}">
                    <option value="${list.name}">${list.name}</option>
                </c:forEach>
            </select>
            </br>
            <input type="submit" value="Add Book to your Cart" name="btAction"/>
            <input type="submit" value="View Your Cart" name="btAction" /><br/>
            <a href="SEARCH_PAGE">Click to here to back search page</a>
        </form>
    </body>
</html>
