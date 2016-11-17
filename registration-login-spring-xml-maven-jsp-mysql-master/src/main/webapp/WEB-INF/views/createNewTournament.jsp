<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Piotrek
  Date: 16-Nov-16
  Time: 12:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form:form action="${contextPath}/createNewTournament" modelAttribute="tournamentForm">
    <table align="left" style="padding-left: 300px;">
        <tr>
            <td
                    style="font-family: 'arial'; font-size: 16px; font-weight: bold;"
                    align="left">Stworz nowy turniej</td>
        </tr>
        <tr align="left">
            <td>
                <table class="border" cellpadding="10">
                    <tr>
                        <td class="td"><b>Nazwa</b></td>
                        <td class="td"><input type="text" name="name" value="${requestScope.tournament.name}"/>
                    </tr>
                    <tr>
                        <td class="td"><b>Typ turnieju</b></td>
                        <td class="td"><input type="text" name="typeTournament" value="${requestScope.tournament.typeTournament}" />
                    </tr>
                    <tr>
                        <td class="td"><b>Kategoria</b></td>
                        <td class="td"><input type="text" name="categoryOfTournament" value="${requestScope.tournament.categoryOfTournament}" />
                    </tr>
                    <tr>
                        <td class="td"><b>Liczba zespolow</b></td>
                        <td class="td"><input type="text" name="maxNumberOfTeam" value="${requestScope.tournament.maxNumberOfTeam}"/>
                    </tr>
                    <tr>
                        <td class="td"><b>Data startu</b></td>
                        <td class="td"><input type="text" name="dateOfBegining" value="${requestScope.tournament.dateOfBegining}"/>
                    </tr>
                    <tr>
                        <td class="td"><b>Stan</b></td>
                        <td class="td"><input type="text" name="stateOfTournament" value="${requestScope.tournament.stateOfTournament}"/>
                    </tr>
                </table>
            </td>
        </tr>
        <tr align="left">
            <td>
                <table style="padding-left: 100px;">
                    <tr align="center">
                        <td class="td"><input type="submit" value="Zapisz" /> &nbsp;
                            &nbsp;<a
                                    href="${pageContext.request.contextPath}/tournament/list"
                                    style="color: green"><b>Wroc</b></a></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
