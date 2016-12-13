<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Piotrek
  Date: 18-Nov-16
  Time: 1:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <link href="<c:url value="/resources/css/site.css" />" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <title>Welcome</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript" src="http://www.technicalkeeda.com/js/javascripts/plugin/json2.js"></script>
    <script src="/resources/demos/external/jquery-mousewheel/jquery.mousewheel.js"></script>
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
        .ui-widget-header { text-align: center; }
        .ui-widget-header { text-align: -webkit-center; }
        .spinner { width: 20px;}
    </style>
    <script type="text/javascript">

        $(function () {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            $(document).ajaxSend(function(e, xhr, options) {
                xhr.setRequestHeader(header, token);
            });
        });
        function makeAjax() {
            $.ajax({
                type: "post",
                url: "/employee/lol",
                cache: false,
                data: { teamList: "${tournament.name}",
                        numberOfrounds : $("#numberOfround").val(),
                        frequency : $("#frequency").val()
                      },
                success: function (response) {
                    $("#generate-schedule").prop("disabled",true);
                },
                error: function () {
                    alert('Error while request..');
                }
            });
        };
        function sendFixtureAjax(tmpId) {
            $.ajax({
                type: "post",
                url: "/fixture/lol",
                cache: false,
                data: {
                        gameId: tmpId,
                        fixtureHome: $("#spinner1").val(),
                        fixtureAway: $("#spinner2").val()
                     },
                success: function (response) {
                   // $("#generate-schedule").prop("disabled",true);
                },
                error: function () {
                    alert('Error while request..');
                }
            });
        };
        $( function() {
           var dialog, form,
           id = $('#id').val(),
           tmpId


            function addUser() {

                makeAjax();
                dialog.dialog( "close" );

            }

            function addFixture() {

                $("#fixture-"+tmpId).html($("#spinner1").val()+":"+$("#spinner2").val());
                sendFixtureAjax(tmpId);
                dialog_fixture.dialog("close");
            }

            dialog = $( "#dialog-form" ).dialog({
                autoOpen: false,
                height: 300,
                width: 300,
                modal: true,
                buttons: {
                    "Generate": addUser,
                    Cancel: function() {
                        dialog.dialog( "close" );
                    }
                },
                close: function() {
                    form[ 0 ].reset();
                }
            });

            dialog_fixture = $( "#dialog-fixture" ).dialog({
                autoOpen: false,
                height: 250,
                width: 580,
                modal: true,
                buttons: {
                    "Generate": addFixture,
                    Cancel: function() {
                        dialog_fixture.dialog( "close" );
                    }
                },
                close: function() {
                    form[ 0 ].reset();
                }
            });

            form = dialog.find( "form" ).on( "submit", function( event ) {
                event.preventDefault();
                addUser();
            });

            $( "#generate-schedule" ).button().on( "click", function() {
                dialog.dialog( "open" );
            });
            $( ".menage" ).bind('click',function(e) {
                tmpId = e.target.id;
                dialog_fixture.dialog( "open" );
                $('#firstName2').val($("#home-"+tmpId).html().trim());
                $('#lastName2').val($("#away-"+tmpId).html().trim());

            });




        });
        $( function() {
            $( "#spinner1" ).spinner({
                spin: function( event, ui ) {
                     if ( ui.value < 0 ) {
                        $( this ).spinner( "value", 0 );
                        return false;
                    }
                }
            });
            $( "#spinner2" ).spinner({
                spin: function( event, ui ) {
                    if ( ui.value < 0 ) {
                        $( this ).spinner( "value", 0 );
                        return false;
                    }
                }
            });
        } );
    </script>

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
            <div class="panel panel-default">
                <div class="panel-heading">Widok turnieju:</div>
                <div class="panel-body">
                    <div>
                        <label> Nazwa: <c:out value="${tournament.name}" /></label>
                    </div>
                    <div>
                        <label> Typ rozgrywki: <c:out value="${tournament.typeTournament}" /></label>
                    </div>
                    <div>
                        <label> Kategoria: <c:out value="${tournament.categoryOfTournament}" /></label>
                    </div>
                    <div>
                        <label> Liczba zespolow:<c:out value="${tournament.currentNumberOfTeam}" />/<c:out value="${tournament.maxNumberOfTeam}" /></label>
                    </div>
                    <div>
                        <c:if test="${fn:length(gameList) == 0 && tournament.currentNumberOfTeam == tournament.maxNumberOfTeam}">
                            <button class="btn btn-primary" id="generate-schedule">Generate schedule</button>
                        </c:if>
                        <a href="${contextPath}/schedule/tournamentId=${tournament.id}"
                           class="btn btn-primary">Pokaz terminarz</a>
                    </div>

                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Zespoly:</div>
                <div class="panel-body">
                    <table class="table table-striped table-hover">
                        <thead class="thead-inverse">

                        <th>Nazwa</th>
                        </thead>
                    <tbody>
                    <c:forEach items="${teamList}" var="team">
                        <tr>
                        <td>
                            <c:out value="${team.name}" />
                            </td>
                            <td>
                                <a href="${contextPath}/teamId=${team.id}"
                                   class="btn btn-primary">Widok</a>
                                <a href="${contextPath}/editTeamId=${team.id}"
                                   class="btn btn-primary">Edycja</a>
                                <a href="${contextPath}/sendEmailId=${team.id}"
                                   class="btn btn-primary">Wyslij wiadomosc</a>
                            </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                        </table>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Last games</div>
                <div class="panel-body">
                    <table class="table table-striped table-hover">
                        <thead class="thead-inverse">
                        <th>Data</th>
                        <th>Round</th>
                        <th>Dom</th>
                        <th>Wyjazd</th>
                        <th>Wynik</th>
                        </thead>
                        <tbody>
                        <c:forEach items="${lastGameList}" var="game">
                            <tr>
                                <td>
                                    <fmt:formatDate value="${game.date}" pattern="yyyy-MM-dd" />
                                </td>
                                <td>
                                    <c:out value="${game.round}" />
                                </td>
                                <td id="home-${game.id}">
                                    <c:out value="${game.home.name}" />
                                </td>
                                <td id="away-${game.id}">
                                    <c:out value="${game.away.name}" />
                                </td>
                                <td id="fixture-${game.id}">
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
                                    <button
                                            class="btn btn-primary menage" id="${game.id}">Zarzadzaj</button>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Next games</div>
                <div class="panel-body">
                    <table class="table table-striped table-hover">
                        <thead class="thead-inverse">
                        <th>Data</th>
                        <th>Round</th>
                        <th>Dom</th>
                        <th>Wyjazd</th>
                        <th>Wynik</th>
                        </thead>
                        <tbody>
                        <c:forEach items="${gameList}" var="game">
                            <tr>
                                <td>
                                    <fmt:formatDate value="${game.date}" pattern="yyyy-MM-dd" />
                                </td>
                                <td>
                                    <c:out value="${game.round}" />
                                </td>
                                <td id="home-${game.id}">
                                   <c:out value="${game.home.name}" />
                                </td>
                                <td id="away-${game.id}">
                                    <c:out value="${game.away.name}" />
                                </td>
                                <td id="fixture-${game.id}">
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
                                    <button
                                       class="btn btn-primary menage" id="${game.id}">Zarzadzaj</button>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Table</div>
                <div class="panel-body">
                    <table class="table table-striped table-hover">
                        <thead class="thead-inverse">
                        <th>Name</th>
                        <th>Matches</th>
                        <th>Win</th>
                        <th>Draw</th>
                        <th>Fail</th>
                        <th>Points</th>
                        </thead>
                        <tbody>
                        <c:forEach items="${tournamentTable}" var="game">
                            <tr>
                                <td>
                                    <c:out value="${game.name}" />
                                </td>
                                <td>
                                    <c:out value="${game.countMatch}" />
                                </td>
                                <td>
                                    <c:out value="${game.countWin}" />
                                </td>
                                <td>
                                    <c:out value="${game.countDraw}" />
                                </td>
                                <td>
                                    <c:out value="${game.countFail}" />
                                </td>
                                <td>
                                    <c:out value="${game.countPoints}" />
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
            <a href="${contextPath}/addMatch"
               class="btn btn-primary">Dodaj spotkanie</a>
        </div>
    <div id="dialog-form" title="Generate schedule">

        <form name="employeeForm" method="post">

            <div class="form-group">
                <label for="numberOfround">Number of rounds:</label>
                <select class="form-control" id="numberOfround" >
                    <option value="1">1</option>
                    <option value="2">2</option>
                </select>
            </div>
            <div class="form-group">
                <label for="frequency">Frequency of match:</label>
                <select class="form-control" id="frequency" >
                    <option value="1">Everyday</option>
                    <option value="3">Every 3 days</option>
                    <option value="7">Once a week</option>
                </select>
            </div>


        </form>
    </div>

</div>

<div id="dialog-fixture" title="Add fixture">
        <p class="validateTips">Wypelnij formularz dotyczacy tworzenia zawodnika.</p>

        <form name="employeeForm" method="post" class="form-inline">

            <div class="form-group">
                <input class="form-control" type="text" name="firstName" id="firstName2" value="" readonly style="text-align: center">
            </div>
            <div class="form-group">
                <input class="spinner" id="spinner1" name="value">
               <!-- <input class="form-control" type="text" name="fixture" id="fixture1" value="-:-" style="text-align: center"> -->
            </div>
            <div class="form-group">
                <label >:</label>
            </div>
            <div class="form-group">
                <input class="spinner" id="spinner2" name="value">
                <!--     <input class="form-control" type="text" name="fixture" id="fixture2" value="-:-" style="text-align: center"> -->
            </div>
                 <div class="form-group">
                     <input class="form-control" type="text" name="lastName" id="lastName2" value="" readonly style="text-align: center">
                 </div>

             </form>
         </div>

     </div>

     </body>
     </html>
