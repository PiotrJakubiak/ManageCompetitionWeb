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

    <!-- Bootstrap Core JavaScript -->
    <script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
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
        $(function () {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            $(document).ajaxSend(function(e, xhr, options) {
                xhr.setRequestHeader(header, token);
            });
        });
        function madeAjaxCall(){
            $.ajax({
                type: "post",
                url: "/employee/lol",
                cache: false,
                data:'firstName=' + $("#firstName").val() + "&lastName=" + $("#lastName").val() + "&email=" + $("#email").val(),
                success: function(response){
                },
                error: function(){
                    alert('Error while request..');
                }
            });
        }
    </script>
    <style>
        .table>tbody>tr>td
        {
            vertical-align: inherit;
            color: #ffffff;
            background-color: #383838;
        }
        .table>thead>tr>th {
            vertical-align: bottom;
            border-bottom: none;

        }
        .btn-primary {
            color: #fff;

            border-color: #080808;
        }
        .btn-primary:hover {
            color: #fff;
            background-color: #7fff0c;
            border-color: #080808;
        }
    </style>
    <title>Welcome</title>

</head>
<body>
<jsp:include page="header.jsp" />
<div class="container">

    <div class="grid">
        <a href="${contextPath}/createNewTournament" class="btn btn-primary">Stworz turniej</a>
        <a href="${contextPath}/createNewTeam" class="btn btn-primary">Dodaj druzyne</a>
    </div>

    <div class="content">

        <table class="table table-hover table-striped">
            <thead>
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
                        <td><c:out value="${tournament.name}" /></td>
                        <td><c:out value="${tournament.currentNumberOfTeam}" />/<c:out value="${tournament.maxNumberOfTeam}" /></td>
                        <td><c:out value="${tournament.categoryOfTournament}" /></td>
                        <td><fmt:formatDate value="${tournament.dateOfBegining}" pattern="yyyy-MM-dd" /></td>
                        <td><c:out value="${tournament.typeTournament}" /></td>
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
                                <span class="glyphicon glyphicon-eye-open"></span> View
                            </a>

                            <c:choose>
                                <c:when test="${tournament.currentNumberOfTeam eq tournament.maxNumberOfTeam}">
                                 <!--   <a href="${contextPath}/viewTournamentId=${tournament.id}"
                                       class="btn btn-primary disabled_button" data-toggle="tooltip" title="Tournament in progress" >Dolacz</a> -->
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
    -->
    <jsp:include page="footer.jsp"/>
</div>

</body>
</html>
