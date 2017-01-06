<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>jQuery UI Dialog - Modal form</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript" src="http://www.technicalkeeda.com/js/javascripts/plugin/json2.js"></script>
    <style>
        label, input { display:block; }
        input.text { margin-bottom:12px; width:95%; padding: .4em; }
        fieldset { padding:0; border:0; margin-top:25px; }
        h1 { font-size: 1.2em; margin: .6em 0; }
        div#users-contain { width: 350px; margin: 20px 0; }
        div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
        div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
        .ui-dialog .ui-state-error { padding: .3em; }
        .validateTips { border: 1px solid transparent; padding: 0.3em; }
    </style>
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>

</head>

<jsp:include page="header.jsp"/>

<div class="container">
    <div class="row">
        <div class="nadawca col-lg-6  col-md-6 col-sm-6">
            <div>
                <a href="${contextPath}/createNewTournament" class="btn btn-primary">Stworz turniej</a>
                <a href="${contextPath}/createNewTeam" class="btn btn-primary">Dodaj druzyne</a>
            </div>
            <div>
                <h2>Tworzenie nowej druzyny</h2>
            </div>
            <div>
                <form:form method="POST" action="${contextPath}/createNewTeam" modelAttribute="teamForm" >

                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label>Nazwa drużyny:</label>
                    <form:input name="name" class="form-control" path="name" type="text" autofocus="true"/>
                    <form:errors path="name" style="color:red"></form:errors>
                </div>
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label>Email kontaktowy:</label>
                    <form:input name="emailContact" class="form-control" path="emailContact" type="text" autofocus="true"/>
                    <form:errors path="emailContact" style="color:red"></form:errors>
                </div>
                <div class="form-group ${status.error ? 'has-error' : ''}">
                    <label>Kategoria wiekowa:</label>
                    <form:select class="form-control" id="selectCategory" path="category" >
                        <form:option value="Junior">Junior</form:option>
                        <form:option value="Open">Open</form:option>
                    </form:select>
                </div>
            </div>
        </div>
        <div class="nadawca col-lg-6  col-md-6 col-sm-6">

        </div>
    </div>
</div>
        <div class="container">

            <div class="row">


                <div>
                    <div>
                        <h3>Zawodnicy:</h3>
                    </div>
                    <table class="table">
                        <thead>
                        <th>Lp.</th>
                        <th>Imie</th>
                        <th>Nazwisko</th>
                        <th>Pozycja</th>
                        <th>Numer</th>


                        </thead>
                        <tbody>
                        <c:forEach items="${teamForm.players}" var="player" varStatus="status">
                            <tr>
                                <td align="center">${status.count}</td>
                                <td>
                                    <form:input name="players[${status.index}].name" path="players[${status.index}].name" class="form-control"/>
                                </td>
                                <td>
                                    <form:input name="players[${status.index}].lastName" path="players[${status.index}].lastName" class="form-control"/>
                                </td>
                                <td>
                                    <form:select class="form-control" path="players[${status.index}].position" >
                                        <form:option value="Bramkarz">Bramkarz</form:option>
                                        <form:option value="Obronca">Obronca</form:option>
                                        <form:option value="Pomocnik">Pomocnik</form:option>
                                        <form:option value="Napastnik">Napastnik</form:option>
                                    </form:select>
                                </td>
                                <td align="center">
                                    <form:input name="players[${status.index}].number" path="players[${status.index}].number" class="form-control" readonly="true"/>
                                </td>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div>
                    <button class="btn btn-primary" type="submit" >Zapisz</button>

                    <a href="${pageContext.request.contextPath}/welcome" class="btn btn-primary"> Wroc </a>

                </div>
            </div>
        </div>

        </form:form>

    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>
