<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Piotrek
  Date: 18-Nov-16
  Time: 1:24 PM
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
            <div class="panel panel-default">
                <div class="panel-heading">Widok turnieju:</div>
                <div class="panel-body">
                    <div>
                        <label> Nazwa: <c:out value="${tournament.name}" /></label>
                    </div>
                    <div>
                        <label> Typ rozgrywki: <c:out value="${tournament.typeTournament}" /></label>
                    </div>
                    <div>
                        <label> Kategoria: <c:out value="${tournament.categoryOfTournament}" /></label>
                    </div>
                    <div>
                        <label> Liczba zespolow:<c:out value="${tournament.currentNumberOfTeam}" />/<c:out value="${tournament.maxNumberOfTeam}" /></label>
                    </div>

                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Zespoly:</div>
                <div class="panel-body">
                    <table class="table table-striped table-hover">
                        <thead class="thead-inverse">

                        <th>Nazwa</th>
                        </thead>
                    <tbody>
                    <c:forEach items="${teamList}" var="team">
                        <tr>
                        <td>
                            <c:out value="${team.name}" />
                            </td>
                            <td>
                                <a href="${contextPath}/teamId=${team.id}"
                                   class="btn btn-primary">Widok</a>
                                <a href="${contextPath}/editTeamId=${team.id}"
                                   class="btn btn-primary">Edycja</a>
                            </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                        </table>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Spotkania:</div>
                <div class="panel-body">
                    <table class="table table-striped table-hover">
                        <thead class="thead-inverse">

                        <th>Dom</th>
                        <th>Wyjazd</th>
                        <th>Wynik</th>
                        </thead>
                        <tbody>
                        <c:forEach items="${gameList}" var="game">
                            <tr>
                                <td>
                                    <c:out value="${game.home.name}" />
                                </td>
                                <td>
                                    <c:out value="${game.away.name}" />
                                </td>
                                <td id="${game.id}">

                                </td>
                                <td>
                                    <a href="${contextPath}/teamId=${game.id}"
                                       class="btn btn-primary">Podglad</a>
                                    <a href="${contextPath}/editTeamId=${game.id}"
                                       class="btn btn-primary">Zarzadzaj</a>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
            <a href="${contextPath}/addMatch"
               class="btn btn-primary">Dodaj spotkanie</a>
        </div>
    </div>
<div id="dialog-form" title="Add new player">
    <p class="validateTips">Wypelnij formularz dotyczacy tworzenia zawodnika.</p>

    <form name="playerForm" method="post">

        <div class="form-group">
            <label for="firstName">First name:</label>
            <input class="form-control" type="text" name="firstName" id="firstName" value="">
        </div>

        <div class="form-group">
            <label for="lastName">Last Name:</label>
            <input class="form-control" type="text" name="lastName" id="lastName" value="">
        </div>
        <div class="form-group">
            <label for="birthdate">Birth day:</label>
            <div class='input-group birthday' id='datetimepicker4'>

                <input type='text' class="form-control" name="birthdate" id="birthdate" value=""/>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-time"></span>
                        </span>
            </div>
        </div>

        <div class="form-group">
            <label for="position">Position:</label>
            <select class="form-control" id="position" >
                <option value="Bramkarz">Bramkarz</option>
                <option value="Obronca">Obronca</option>
                <option value="Pomocnik">Pomocnik</option>
                <option value="Napastnik">Napastnik</option>
            </select>
        </div>

        <div class="form-group">
            <label for="number">Number:</label>
            <input class="form-control" type="text" name="number" id="number" value="">
        </div>

    </form>
</div>
</body>
</html>
