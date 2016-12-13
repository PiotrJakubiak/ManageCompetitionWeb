<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Email with Spring MVC</title>
</head>
<body>
    <h1>Sending e-mail with Spring MVC</h1>
    <form:form method="post" modelAttribute="emailDTO" action="sendMessage">
        <table border="0" width="80%">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <tr>
                <td>To:</td>
                <td><input path="id" type="text" name="id" size="65" value="${emailDTO.id}"/></td>
            </tr>
            <tr>
                <td>Subject:</td>
                <td><input path="subject" type="text" name="subject" size="65" /></td>
            </tr>
            <tr>
                <td>Message:</td>
                <td><textarea path="text" cols="50" rows="10" name="text"></textarea></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="Send E-mail" />
                </td>
            </tr>
        </table>
    </form:form>

</body>
</html>