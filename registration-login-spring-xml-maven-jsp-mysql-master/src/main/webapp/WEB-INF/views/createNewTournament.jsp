<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <title>Create new tournament</title>

</head>
<body>
<jsp:include page="header.jsp"/>
<div class="row">
    <div class="col-xs-6 col-md-4"></div>
    <div class="col-xs-6 col-md-4">
        <div>
            <a href="${contextPath}/createNewTournament" class="btn btn-primary">Stworz turniej</a>
            <a href="${contextPath}/createNewTeam" class="btn btn-primary">Dodaj druzyne</a>
        </div>
        <div>
            <form:form action="${contextPath}/createNewTournament" modelAttribute="tournamentForm" id="commentForm" enctype="multipart/form-data">
            <div>
                <h2>Tworzenie nowego turnieju</h2>

            </div>

                <div>
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <form:errors path="isOlder18" style="color:red"></form:errors>
                    </div>
                </div>
            <div>
                <label>Nazwa turnieju:</label>
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input path="name" class="form-control" type="text" name="name" value="${requestScope.tournament.name}"/>
                    <form:errors path="name" style="color:red"></form:errors>
                </div>
            </div>
            <div>
                <label>Typ rozgrywki:</label>
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:radiobutton class="radio-inline" path="typeTournament" value="Liga"/>Liga
                    <form:radiobutton class="radio-inline" path="typeTournament" value="Play-off"/>Play-off
                    <form:radiobutton class="radio-inline" path="typeTournament" value="Turniej"/>Grupy + Play-off
                    <form:errors path="typeTournament" style="color:red"></form:errors>
                </div>
            </div>
            <div>
                <label>Kategoria wiekowa:</label>
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:select class="form-control" id="selectCategory" path="categoryOfTournament" >
                        <form:option value="Junior">Junior</form:option>
                        <form:option value="Open">Open</form:option>
                    </form:select>
                </div>
            </div>
            <div>
                <label>Liczba drużyn:</label>
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <form:input class="form-control" path="maxNumberOfTeam" type="text" name="maxNumberOfTeam" value="${requestScope.tournament.maxNumberOfTeam}" />
                    <form:errors path="maxNumberOfTeam" style="color:red"></form:errors>
                </div>
            </div>
            <div>
                <label>Data startu:</label>
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <div class='input-group date' id='datetimepicker4'>
                        <form:input path="dateOfBegining" type='text' class="form-control" name="dateOfBegining" value="${requestScope.tournament.dateOfBegining}"/>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                    </div>
                    <form:errors path="dateOfBegining" style="color:red"></form:errors>
                </div>
            </div>
                <div class="form-group">
                    <label for="comment">Opis turnieju:</label>
                    <form:textarea class="form-control" path="description" rows="5" id="comment" ></form:textarea>
                </div>
            <div>
                <form:input type="file" name="data" path="fileData" class="form-control" />
            </div>
            <div>
                <button class="btn btn-primary" type="submit" >Zapisz</button>
                <a href="${pageContext.request.contextPath}/welcome" class="btn btn-primary"> Wroc </a>
            </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            </form:form>
        </div>
    </div>

    <div class="col-xs-6 col-md-4"></div>
</div>

<script type="text/javascript">
    $(document).ready(function() {

            $('#datetimepicker4').datetimepicker({
                format: 'YYYY/MM/DD'
            });
    });

</script>
<jsp:include page="footer.jsp"/>
</body>
</html>
