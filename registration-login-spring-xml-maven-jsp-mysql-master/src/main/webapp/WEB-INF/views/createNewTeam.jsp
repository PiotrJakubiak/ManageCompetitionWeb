<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Piotrek
  Date: 11/14/2016
  Time: 9:57 PM
  To change this template use File | Settings | File Templates.
--%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container">

    <form:form method="POST" action="${contextPath}/createNewTeam" modelAttribute="teamForm" >
        <h2 class="form-heading">Log in</h2>

            <h2>Nazwa zespolu:</h2>
            <form:input name="name" path="name" type="text" autofocus="true"/>
            <h2>Skrocona nazwa:</h2>
            <form:input name="shortName" path="shortName" type="text" autofocus="true"/>
            <h2>Zawodnicy:</h2>
            <h2>${pageContext.request.userPrincipal.name} </h2>
            <h2>${userForm} </h2>

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Log In</button>



    </form:form>

</div>

</body>
</html>
