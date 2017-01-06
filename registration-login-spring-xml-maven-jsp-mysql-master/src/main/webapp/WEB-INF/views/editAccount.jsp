<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <title>Welcome</title>

</head>
<body>
<jsp:include page="header.jsp" />
<div class="row">
    <div class="col-xs-6 col-md-4"></div>
    <div class="col-xs-6 col-md-4">
        <div class="grid">
            <a href="${contextPath}/createNewTournament" class="btn btn-primary">Stworz turniej</a>
            <a href="${contextPath}/createNewTeam" class="btn btn-primary">Dodaj druzyne</a>
        </div>
        <div>

            <form:form method="post" modelAttribute="teamDTO" action="/saveEditTeam">
                <div>
                    <label>Identyfikator:</label>
                    <form:input path="id" class="form-control" value="${team.id}"/>
                </div>
                <div>
                    <label>Nazwa:</label>
                    <form:input path="name" class="form-control" value="${team.name}"/>
                </div>
                <div>
                    <label>Krótka nazwa:</label>
                    <form:input path="shortName" class="form-control" value="${team.shortName}"/>
                </div>
                <div>
                    <label>Kategoria:</label>
                    <form:input path="category" class="form-control" value="${team.category}"/>
                </div>
                <div>
                    <label>Email kontaktowy:</label>
                    <form:input path="emailContact" class="form-control" value="${team.emailContact}"/>
                </div>
                <div>
                    <button class="btn btn-primary" type="submit">Zapisz</button>
                </div>

            </form:form>

        </div>
    </div>
    <div class="col-xs-6 col-md-4"> </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
