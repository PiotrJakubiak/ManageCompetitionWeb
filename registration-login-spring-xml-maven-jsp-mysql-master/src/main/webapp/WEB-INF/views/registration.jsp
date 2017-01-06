<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<head>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <title>Kreator tworzenia nowego użytkownika</title>

</head>

<body>
<jsp:include page="header.jsp"/>
    <div class="container">
            <div class="row">
                <div class="col-xs-6 col-md-4"></div>
                <div class="col-xs-6 col-md-4">
                    <div>
                        <h2 class="form-signin-heading">Tworzenie nowego konta</h2>
                    </div>

                    <form:form method="POST" modelAttribute="userForm" class="form-signin">


                        <spring:bind path="username">
                            <label>Login: *</label>
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <form:input type="text" path="username" class="form-control" placeholder="Login"
                                            autofocus="true"></form:input>
                                <form:errors path="username"></form:errors>
                            </div>
                        </spring:bind>



                        <spring:bind path="password">
                            <label>Haslo: *</label>
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <form:input type="password" path="password" class="form-control" placeholder="Haslo"></form:input>
                                <form:errors path="password"></form:errors>
                            </div>
                        </spring:bind>

                        <spring:bind path="passwordConfirm">
                            <label>Potwierdz haslo: *</label>
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <form:input type="password" path="passwordConfirm" class="form-control"
                                            placeholder="Potwierdz swoje haslo"></form:input>
                                <form:errors path="passwordConfirm"></form:errors>
                            </div>
                        </spring:bind>

                        <spring:bind path="email">
                            <label>E-mail: *</label>
                            <div class="form-group ${status.error ? 'has-error' : ''}">
                                <form:input type="email" path="email" class="form-control"
                                            placeholder="E-mail"></form:input>
                                <form:errors path="email"></form:errors>
                            </div>
                        </spring:bind>
                    <spring:bind path="name">
                        <label>Imie:</label>
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            <form:input type="text" path="name" class="form-control" placeholder="Imie"
                                        autofocus="true"></form:input>
                            <form:errors path="name"></form:errors>
                        </div>
                    </spring:bind>

                    <spring:bind path="lastName">
                        <label>Nazwisko:</label>
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            <form:input type="text" path="lastName" class="form-control" placeholder="Nazwisko"
                                        autofocus="true"></form:input>
                            <form:errors path="lastName"></form:errors>
                        </div>
                    </spring:bind>

                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <label>Data urodzenia:</label>
                        <div class='input-group date' id='datetimepicker4'>
                            <form:input path="birthDay" type='text' class="form-control" name="birthDay" value="2000-01-01" />
                                    <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span>
                                    </span>
                        </div>
                        <form:errors path="birthDay" style="color:red"></form:errors>
                    </div>

                    <button class="btn btn-primary " type="submit">Register</button>
                    <a href="${pageContext.request.contextPath}/welcome" class="btn btn-primary"> Wroc </a>
                    </form:form>
                </div>
                <div class="col-xs-6 col-md-4"></div>
            </div>
        </div>
    </div>
<script type="text/javascript">
    $(document).ready(function() {

        $('#datetimepicker4').datetimepicker({
            format: 'YYYY/MM/DD'
        });
    });

</script>
<jsp:include page="footer.jsp"/>
</body>
</html>
