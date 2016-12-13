<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <link href="<c:url value="/resources/css/site.css" />" rel="stylesheet">
    <title>Create an account</title>

</head>

<body>

    <div class="container">
        <header>
            <div class="container">
                <a href="${contextPath}/login" id="home_page"><h1>ManageCompetition</h1></a>
                <nav>
                    asdasdas
                </nav>
            </div>
        </header>
        <div class="content">
            <div id="register-form">
                <form:form method="POST" modelAttribute="userForm" class="form-signin">
                    <h2 class="form-signin-heading">Create your account</h2>
                    <spring:bind path="username">
                        <label>Username:</label>
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            <form:input type="text" path="username" class="form-control" placeholder="Username"
                                        autofocus="true"></form:input>
                            <form:errors path="username"></form:errors>
                        </div>
                    </spring:bind>

                    <spring:bind path="password">
                        <label>Password:</label>
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            <form:input type="password" path="password" class="form-control" placeholder="Password"></form:input>
                            <form:errors path="password"></form:errors>
                        </div>
                    </spring:bind>

                    <spring:bind path="passwordConfirm">
                        <label>Confirm password:</label>
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            <form:input type="password" path="passwordConfirm" class="form-control"
                                        placeholder="Confirm your password"></form:input>
                            <form:errors path="passwordConfirm"></form:errors>
                        </div>
                    </spring:bind>

                    <spring:bind path="email">
                        <label>Email:</label>
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            <form:input type="email" path="email" class="form-control"
                                        placeholder="Your email"></form:input>
                            <form:errors path="email"></form:errors>
                        </div>
                    </spring:bind>

                <button class="btn btn-lg btn-primary btn-block" type="submit">Register</button>
                </form:form>
            </div>
        </div>
    </div>
</body>
</html>
