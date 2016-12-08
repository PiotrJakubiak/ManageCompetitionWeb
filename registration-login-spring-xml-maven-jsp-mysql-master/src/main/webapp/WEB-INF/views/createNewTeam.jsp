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
    <link href="<c:url value="/resources/css/site.css" />" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>

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
        <form:form method="POST" action="${contextPath}/createNewTeam" modelAttribute="teamForm" >
            <h2>Tworzenie nowej druzyny</h2>
            <table class="table table-striped">
                <tr>
                    <td class="td"><b>Nazwa zepołu:</b></td>
                    <td class="td">
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            <form:input name="name" class="form-control" path="name" type="text" autofocus="true"/>
                        </div>
                        <form:errors path="name" style="color:red"></form:errors>
                    </td>
                </tr>
                <tr>
                    <td class="td"><b>Email kontaktowy:</b></td>
                    <td class="td">
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            <form:input name="emailContact" class="form-control" path="emailContact" type="text" autofocus="true"/>

                        </div>
                        <form:errors path="emailContact" style="color:red"></form:errors>
                    </td>
                </tr>
                <tr>
                    <td class="td"><b>Kategoria wiekowa:</b></td>
                    <td class="td">
                        <div class="form-group ${status.error ? 'has-error' : ''}">
                            <form:select class="form-control" id="selectCategory" path="category" >
                                <form:option value="Junior">Junior</form:option>
                                <form:option value="Open">Open</form:option>
                            </form:select>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <br />
                    </td>
                </tr>
            </table>
                </td>
                </tr>
                <tr align="left">
                    <td>
                        <table class="table table-striped">
                            <tr align="center">
                                <td class="td">
                                    <button class="btn btn-primary" type="submit" >Zapisz</button>

                                    <a href="${pageContext.request.contextPath}/welcome" class="btn btn-primary"> Wroc </a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

            </form:form>

    </div>
</div>
</body>
</html>
