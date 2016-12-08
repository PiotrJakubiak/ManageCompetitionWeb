<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <link href="<c:url value="/resources/css/site.css" />" rel="stylesheet">


    <title>Log in with your account</title>
</head>

<body>
    <div class="center-log-in-page">
        <div id="log-in-form">
            <form method="POST" action="${contextPath}/login" class="form-signin">
                <div>
                    <h5>Member Login</h5>
                    <tr />
                </div>
                <div>
                    <label>Username:</label>
                    <input id="username" class="form-control" name="username" type="text" placeholder="Username" autofocus="true"/>
                </div>
                <div>
                    <label>Password:</label>
                    <input id="password" class="form-control" name="password" type="password" placeholder="Password"/>
                </div>
                <div>
                    <span class="error">${error}</span>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </div>

                <button class="btn btn-primary btn-block" type="submit">Log In</button>
                <div id="register">
                    <labe>Not a member yet?</labe><a href="${contextPath}/registration">Register</a>
                </div>
            </form>
        </div>

    </div>
</body>
</html>
