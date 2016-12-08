<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Piotrek
  Date: 16-Nov-16
  Time: 1:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <link href="<c:url value="/resources/css/site.css" />" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <title>Welcome</title>

</head>
<body>
<header>
    <div class="container">
        <a href="${contextPath}/welcome" id="home_page"><h1>ManageCompetition</h1></a>
        <nav>
            asdasdas
        </nav>
        <div class="user-info">
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <form id="logoutForm" method="POST" action="${contextPath}/logout">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>

                <h5> Welcome ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()">Logout</a></h5>

            </c:if>
            <img src="http://icons.iconseeker.com/ico/application-interface/user-5.ico" alt="user" />

            </form>
        </div>
    </div>
</header>
<div class="container">

    <div class="grid">
        <a href="${contextPath}/createNewTournament" class="btn btn-primary">Stworz turniej</a>
        <a href="${contextPath}/createNewTeam" class="btn btn-primary">Dodaj druzyne</a>
    </div>

    <div class="content">
        <h5>Wybierz zespol który chciałbyś dołączyć do turnieju </h5>

        <div>
        <form:form method="POST" action="${contextPath}/createNewPlayer" modelAttribute="tournamentTeamDTO" >

            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input path="tournament" value="${tournament.id}" readonly="true" cssStyle="display: none"/>
                <form:errors path="tournament" style="color:red"></form:errors>
            </div>
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:select class="form-control" path="team" items="${userTeams}" var="userTeam" >
                    <form:options itemLabel="${userTeam}" itemValue="${userTeam}"/>
                </form:select>
                <form:errors path="team" style="color:red"></form:errors>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div>
                <button class="btn btn-primary" type="submit">Dodaj</button>
                <a href="${contextPath}/welcome" class="btn btn-primary">Wroc</a>
            </div>





        </form:form>
        </div>
    </div>
</div>
</body>
</html>
