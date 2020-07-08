<%-- 
    Document   : search
    Created on : Feb 27, 2020, 9:26:20 AM
    Author     : kusmi
--%>

<%@page import="locnt.registration.RegistrationDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
    </head>
    <body>
        <c:if test="${empty sessionScope}">
            <c:redirect url="LOGIN_PAGE"/>
        </c:if>
        <font color="red">
        Welcome, ${sessionScope.FULLNAME}
        </font>
        <br/>

        <c:url var="logout" value="logout">
            <c:param name="btAction" value="Logout" />
        </c:url>
        <a href="${logout}">Logout</a>


        <h1>Search Page</h1>
        
        <a href="showProduct">Click to here to shopping!!!!</a>
        <form action="searchLastname">
            Search Value <input type="text" name="txtSearchValue" value="${param.txtSearchValue}" />
            <input type="submit" value="Search" name="btAction"/>
        </form>

        <br/>

        <c:set var="searchValue" value="${param.txtSearchValue}" />
        <c:if test="${not empty searchValue }">
            <c:set var="result" value="${requestScope.SEARCHRESULT}" />
            <c:if test="${not empty result}" >
                <table border="1">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>Full name</th>
                            <th>Role</th>
                            <th>Delete</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dto" items="${result}" varStatus="counter" >
                        <form action="updatePassRole">

                            <tr>
                                <td>
                                    ${counter.count}
                                </td>
                                <td>
                                    ${dto.username}
                                    <input type="hidden" name="txtUsername" value="${dto.username}" />
                                </td>
                                <td>
                                    <input type="text" name="txtPassword" value="${dto.password}" />
                                </td>
                                <td>
                                    ${dto.lastname}
                                </td>
                                <td>
                                    <input type="checkbox" name="chkAdmin" value="ON" 
                                           <c:if test="${dto.role}" > 
                                               checked="checked" 
                                           </c:if> />
                                </td>
                                <td>
                                    <c:url var="delLink" value="deleteAccount">
                                        <c:param name="btAction" value="Delete" />
                                        <c:param name="pk" value="${dto.username}"/>
                                        <c:param name="lastSearchValue" value="${searchValue}"/>
                                    </c:url>
                                    <a href="${delLink}">Delete</a>
                                </td>
                                <td>
                                    <input type="submit" value="Update" name="btAction" />
                                    <input type="hidden" name="lastSearchValue" value="${searchValue}" />
                                </td>
                            </tr>
                        </form>

                    </c:forEach>
                </tbody>
            </table>

        </c:if>
        <c:if test="${empty result}" >
            <h2>
                No record is match
            </h2>
            
        </c:if>
    </c:if>
    
</body>
</html>
