<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <script src="<c:url value="/resources/js/jquery.js"/>"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</head>
<body>
<jsp:include page="header.jsp" />
<div class="row">
    <div class="col-xs-6 col-md-4"></div>
    <div class="col-xs-6 col-md-4">
        <div>
            <h3>Dane użytkownika:</h3>
        </div>
        <div>
            <label>Nazwa użytkownika:</label>
            <c:out value="${user.username}" />
        </div>
        <div>
            <label>Email:</label>
            <c:out value="${user.email}" />
        </div>
        <div>
            <label>Imie:</label>
            <c:out value="${user.name}" />
        </div>
        <div>
            <label>Nazwisko:</label>
            <c:out value="${user.lastName}" />
        </div>
        <div>
            <label>Data urodzenia:</label>
            <fmt:formatDate value="${user.birthDay}" pattern="yyyy-MM-dd" />
        </div>
        <div>
            <a href=""
               class="btn btn-primary">Edycja</a>
        </div>
        <div>
            <h3>Drużyny użytkownika:</h3>
        </div>
        <div>
            <table class="table table-hover">
                <thead>
                    <th>Nazwa</th>
                    <th>Kategoria</th>
                </thead>

                <tbody>

                 <c:forEach items="${team}" var="team">
                    <tr>
                       <td>
                           <c:out value="${team.name}" />
                       </td>
                        <td>
                            <c:out value="${team.category}" />
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
        <div>
            <h3>Turnieje użytkownika:</h3>
        </div>
        <div>
            <table class="table table-hover">
                <thead>
                <th>Nazwa</th>
                </thead>

                <tbody>
                    <c:forEach items="${tournament}" var="tournament">
                        <tr>
                            <td>
                                <c:out value="${tournament.name}" />
                            </td>
                            <td>
                                <a href="${contextPath}/tournamentId=${tournament.id}"
                                   class="btn btn-primary">Widok</a>
                            </td>
                        </tr>

                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-xs-6 col-md-4"></div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
