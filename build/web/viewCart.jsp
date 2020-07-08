<%-- 
    Document   : viewCart
    Created on : Mar 5, 2020, 10:31:04 AM
    Author     : kusmi
--%>

<%@page import="java.util.Map"%>
<%@page import="locnt.cart.CartObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SuperMarket</title>
    </head>
    <body>
        <h1>View Your Cart</h1>
        <c:set var="cart" value="${sessionScope.CART}"/>
        <c:if test="${not empty cart}">
            <c:if test="${not empty cart.getItems()}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Title</th>
                            <th>Quantity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <form action="remove">
                        <c:forEach var="type" items="${CART.getItems()}" varStatus="counter">
                            <tr>
                                <td>
                                    ${counter.count}
                                </td>
                                <td>
                                    ${type.key}
                                </td>
                                <td>
                                    ${type.value}
                                </td>
                                <td>
                                    <input type="checkbox" name="chkItem" value="${type.key}"/>
                                </td>
                            </tr>

                        </c:forEach>

                        <tr>
                            <td colspan="3">
                                <a href="showProduct">Add More Books to Your Cart</a>
                            </td>
                            <td>
                                <input type="submit" value="Remove Items" name="btAction" />
                            </td>
                        </tr>
                    </form>

                </tbody>
                <form action="checkout">
                    <input type="submit" value="Checkout" name="btAction" />
                </form>
            </table>
        </c:if>
    </c:if>


    <c:if test="${CART.getItems() == null}">
        <h2>
            <font color="red">No Cart is existed!!!!</font>
        </h2>
        <a href="addItemToCart">Click to here to back</a>
    </c:if>
    <br/>
    <a href="SEARCH_PAGE">Click to here to back search page</a>

</body>
</html>
