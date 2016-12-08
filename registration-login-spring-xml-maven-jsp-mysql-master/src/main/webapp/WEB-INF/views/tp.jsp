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
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <link href="<c:url value="/resources/css/site.css" />" rel="stylesheet">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Log in with your account</title>
</head>

<body>

<header>
    <div class="container">
        <a href="${contextPath}/login" id="home_page"><h1>ManageCompetition</h1></a>
        <nav>
            asdasdas
        </nav>
        <div class="user-info">
            <form method="POST" action="${contextPath}/login" class="form-signin">
                <input name="username" type="text" class="form-control" placeholder="Username"
                       autofocus="true"/>
                <input name="password" type="password" class="form-control" placeholder="Password"/>
                <button class="btn btn-primary" type="submit">Log In</button>
                <br/>
                <span class="error">${error}</span>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <img id="img" src="http://icons.iconseeker.com/ico/application-interface/user-5.ico" alt="user" />

            </form>
        </div>
    </div>
</header>
<div class="container">
    <div class="grid">
        <a href="${contextPath}/createNewTournament" class="btn btn-primary">Stworz turniej</a>
        <a href="${contextPath}/registration" class="btn btn-primary" >Rejestracja</a>
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
            <th>Stan</th>
            <th>Typ</th>
            </thead>
            <tbody>
            <c:forEach items="${tournamentsList}" var="tournament">
                <tr>
                    <td><c:out value="${tournament.id}" /></td>
                    <td><c:out value="${tournament.name}" /></td>
                    <td><c:out value="${tournament.currentNumberOfTeam}" />/<c:out value="${tournament.maxNumberOfTeam}" /></td>
                    <td><c:out value="${tournament.categoryOfTournament}" /></td>
                    <td><c:out value="${tournament.dateOfBegining}" /></td>
                    <td><c:out value="${tournament.stateOfTournament}" /></td>
                    <td><c:out value="${tournament.typeTournament}" /></td>
                    <td>
                        <a href="${contextPath}/tournamentId=${tournament.id}"
                           class="btn btn-primary">Widok</a>
                        <a href="${contextPath}/viewTournamentId=${tournament.id}"
                           class="btn btn-primary">Dolacz</a>
                        <a href="${contextPath}/viewTournamentId=${tournament.id}"
                           class="btn btn-primary">Edycja</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</div>
<c:if test="${pageContext.request.userPrincipal.name != null}">

    1
    3
    4
</c:if>


<script>
    $(document).ready(function() {

        $( "#footer").load("footer.jsp", function() {
            alert( "Load was performed." );
        });

    });
</script>

</body>
</html>
