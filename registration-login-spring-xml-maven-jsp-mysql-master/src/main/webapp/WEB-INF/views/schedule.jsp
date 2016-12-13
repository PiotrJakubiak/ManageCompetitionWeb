<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Piotrek
  Date: 09-Dec-16
  Time: 3:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="panel panel-default">
    <div class="panel-heading">Spotkania:</div>
    <div class="panel-body">
        <table class="table table-striped table-hover">
            <thead class="thead-inverse">
            <th>Round</th>
            <th>Dom</th>
            <th>Wyjazd</th>
            <th>Wynik</th>
            </thead>
            <tbody>
            <c:set var="round" scope="session" value="1"/>
            <c:forEach items="${gameList}" var="game">
                <tr>
                    <td>
                        <c:out value="${game.round}" />
                    </td>
                    <td>
                        <c:out value="${game.home.name}" />
                    </td>
                    <td>
                        <c:out value="${game.away.name}" />
                    </td>
                    <td id="${game.id}">
                        <c:if test="${game.goals_home != '-1'}">
                            <c:out value="${game.goals_home}" />:<c:out value="${game.goals_away}" />
                        </c:if>
                        <c:if test="${game.goals_home eq '-1'}">
                            -:-
                        </c:if>
                    </td>
                    <td>
                        <a href="${contextPath}/teamId=${game.id}"
                           class="btn btn-primary">Podglad</a>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
</div>
</body>
</html>
