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
    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <script src="<c:url value="/resources/js/jquery.js"/>"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>

</head>
<body>
<jsp:include page="header.jsp" />

<div class="container">
    <div class="row">
        <div class="nadawca col-lg-6  col-md-6 col-sm-6">
            <div class="grid">
                <a href="${contextPath}/createNewTournament" class="btn btn-primary">Stworz turniej</a>
                <a href="${contextPath}/createNewTeam" class="btn btn-primary">Dodaj druzyne</a>
                <a href="${contextPath}/welcome" class="btn btn-primary">Wroc</a>
            </div>
            <div>
                <h2>Dane drużyny:</h2>
            </div>
            <div>
                <label>Nazwa drużyny:</label>  <c:out value="${team.name}" />
            </div>
            <div>
                <label>Kategoria wiekowa:</label>  <c:out value="${team.category}" />
            </div>
            <div>
                <label>Email kontaktowy:</label>  <c:out value="${team.emailContact}" />
            </div>
        </div>
        <div class="nadawca col-lg-6  col-md-6 col-sm-6">
            <div>
                <h2>Turnieje drużyny:</h2>
            </div>
            <div>
                <table class="table table-hover">
                    <thead>

                        <th>Nazwa</th>
                        <th>Stan turnieju</th>

                    </thead>
                    <tbody>
                    <c:forEach items="${listTournamentByTeam}" var="tournament">
                        <tr>
                            <td>
                                <c:out value="${tournament.name}" />
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${tournament.stateOfTournament eq 'Oczekuje'}">
                                        <h4><span class="label label-warning"><c:out value="${tournament.stateOfTournament}" /></span></h4>
                                    </c:when>
                                    <c:when test="${tournament.stateOfTournament eq 'In progress'}">
                                        <h4><span class="label label-success"><c:out value="${tournament.stateOfTournament}" /></span></h4>
                                    </c:when>
                                    <c:otherwise>
                                        <h4><span class="label label-default"><c:out value="${tournament.stateOfTournament}" /></span></h4>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${contextPath}/tournamentId=${tournament.id}"
                                   class="btn btn-primary">
                                    <span class="glyphicon glyphicon-eye-open"></span> Podgląd
                                </a>
                            </td>

                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>
<div class="container">
    <div class="row">
        <div class="nadawca col-lg-6  col-md-6 col-sm-6">
            <div>
                <h2>Zawodnicy:</h2>
            </div>
            <div>
                <table class="table table-hover">
                    <thead>

                    <th>Imie</th>
                    <th>Nazwisko</th>
                    <th>Data urodzenia</th>
                    <th>Pozycja</th>
                    <th>Numer</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${listPlayer}" var="player">
                        <tr>
                            <td>
                                <c:out value="${player.name}" />
                            </td>
                            <td>
                                <c:out value="${player.lastName}" />
                            </td>
                            <td>
                                <c:out value="${player.birthDay}" />
                            </td>
                            <td>
                                <c:out value="${player.position}" />
                            </td>
                            <td>
                                <c:out value="${player.number}" />
                            </td>

                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
        <div class="nadawca col-lg-6  col-md-6 col-sm-6">
            <div>
                <h2>Ostatnie spotkania:</h2>
            </div>
            <div>
                <table class="table table-hover">
                    <thead>

                    <th>Gospodarz</th>
                    <th>Gość</th>

                    </thead>
                    <tbody>
                    <c:forEach items="${listGameByTeam}" var="game">
                        <tr>
                            <td>
                                <c:out value="${game.home.name}" />
                            </td>
                            <td>
                                <c:out value="${game.away.name}" />
                            </td>

                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>
