<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
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
    <script type="text/javascript">
        $(document).ready(function() {

            $('.disabled_button').attr("disabled", true);
            $('[data-toggle="tooltip"]').tooltip();
        });
        $(document).ready(function() {
            $('.disabled_button').click(function(e){
                console.log("dziala")
                e.preventDefault();
            });
        });

    </script>
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

        <table class="table table-striped table-hover">
            <thead>
            <th>ID</th>
            <th>Nazwa</th>
            <th>Liczba druzyn</th>
            <th>Kategoria</th>
            <th>Data rozpoczecia</th>
            <th>Typ</th>
            <th>Stan</th>
            </thead>

            <tbody>
            <c:forEach items="${tournamentsList}" var="tournament">

                    <tr>
                        <td><c:out value="${tournament.id}" /></td>
                        <td><c:out value="${tournament.name}" /></td>
                        <td><c:out value="${tournament.currentNumberOfTeam}" />/<c:out value="${tournament.maxNumberOfTeam}" /></td>
                        <td><c:out value="${tournament.categoryOfTournament}" /></td>
                        <td><fmt:formatDate value="${tournament.dateOfBegining}" pattern="yyyy-MM-dd" /></td>
                        <td><c:out value="${tournament.typeTournament}" /></td>
                        <td><c:out value="${tournament.stateOfTournament}" /></td>
                        <td>
                            <a href="${contextPath}/tournamentId=${tournament.id}"
                               class="btn btn-primary">Widok</a>

                            <c:choose>
                                <c:when test="${tournament.currentNumberOfTeam eq tournament.maxNumberOfTeam}">
                                    <a href="${contextPath}/viewTournamentId=${tournament.id}"
                                       class="btn btn-primary disabled_button" data-toggle="tooltip" title="Tournament in progress" >Dolacz</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${contextPath}/viewTournamentId=${tournament.id}"
                                    class="btn btn-primary" >Dolacz</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>

            </c:forEach>
            </tbody>
        </table>

    </div>


<!--
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h2>Welcome ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()">Logout</a></h2>

    </c:if>
    <a href="${contextPath}/createNewTeam">Create a team</a></h4>
    <br />

    Lista zespolow:
    -->
</div>

</body>
</html>
