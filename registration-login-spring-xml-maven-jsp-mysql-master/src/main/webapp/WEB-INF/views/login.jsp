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
    <link href="<c:url value="/resources/css/site.css" />" rel="stylesheet">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Log in with your account</title>
</head>

<body>

    <header>
        <div class="container">
            <h1>SSF - System Super Faktur</h1>
            <nav>
                asdasdas
            </nav>
            <div class="user-info">
                <form method="POST" action="${contextPath}/login" class="form-signin">
                <input name="username" type="text" class="form-control" placeholder="Username"
                       autofocus="true"/>
                <input name="password" type="password" class="form-control" placeholder="Password"/>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Log In</button>
                    <br/>
                <span id="error">${error}</span>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <img src="http://icons.iconseeker.com/ico/application-interface/user-5.ico" alt="user" />

                </form>
            </div>
        </div>
    </header>
    <div class="container">
        <div class="grid">
                <a href="${contextPath}/createNewTournament" class="btn">Dodaj druzyne</a>
                <a href="${contextPath}/registration">Rejestracja</a>

        </div>

        <table align="left" style="padding-left: 300px;">
            <tr>
                <td
                        style="font-family: 'arial'; font-size: 16px; font-weight: bold;">Lista druzyn</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table class="border" cellpadding="10">
                        <tr bgcolor="#99CCFF">
                            <th class="th">ID</th>
                            <th class="th">Nazwa</th>
                        </tr>
                        <c:forEach items="${teamsList}" var="team">
                            <tr>
                                <td class="td"><c:out value="${team.id}" /></td>
                                <td class="td"><c:out value="${team.name}" /></td>
                            </tr>
                        </c:forEach>
                    </table>
                </td>
            </tr>
        </table>
        <table align="left" style="padding-left: 300px;">
            <tr>
                <td
                        style="font-family: 'arial'; font-size: 16px; font-weight: bold;">Lista turniejow</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table class="border" cellpadding="10">
                        <tr bgcolor="#99CCFF">
                            <th class="th">ID</th>
                            <th class="th">Nazwa</th>
                            <th class="th">Liczba druzyn</th>
                            <th class="th">Kategoria</th>
                            <th class="th">Data rozpoczecia</th>
                            <th class="th">Stan</th>
                            <th class="th">Typ</th>
                        </tr>
                        <c:forEach items="${tournamentsList}" var="tournament">
                            <tr>
                                <td class="td"><c:out value="${tournament.id}" /></td>
                                <td class="td"><c:out value="${tournament.name}" /></td>
                                <td class="td"><c:out value="${tournament.maxNumberOfTeam}" /></td>
                                <td class="td"><c:out value="${tournament.categoryOfTournament}" /></td>
                                <td class="td"><c:out value="${tournament.dateOfBegining}" /></td>
                                <td class="td"><c:out value="${tournament.stateOfTournament}" /></td>
                                <td class="td"><c:out value="${tournament.typeTournament}" /></td>
                                <td class="td">
                                    <a href="${contextPath}/tournamentId=${tournament.id}"
                                       style="color: green">Widok</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
