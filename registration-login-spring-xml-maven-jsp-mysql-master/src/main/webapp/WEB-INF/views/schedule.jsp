<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
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
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
                    $("#generate-schedule").hide();
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
                    tmpId;


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
                    <!--form[ 0 ].reset();-->
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
                    //form[ 0 ].reset();
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

            var player = $("#player");

            function addEvent() {

                $( "#playerEvent" ).append("<tr><td>"+player.val()+"</td></tr>");

            };



            dialog = $( "#eventDialog" ).dialog({
                autoOpen: false,
                height: 300,
                width: 350,
                modal: true,
                buttons: {
                    Cancel: function() {
                        addEvent();
                        dialog.dialog( "close" );
                    }
                },
                close: function() {
                    //form[ 0 ].reset();
                    // allFields.removeClass( "ui-state-error" );
                }
            });

            $( "#addEvent" ).button().on( "click", function() {
                dialog.dialog( "open" );
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
<jsp:include page="header.jsp" />
<div class="row">
    <div class="col-xs-6 col-md-4"></div>
    <div class="col-xs-6 col-md-4">
        <div>
            <h2>Spotkania:</h2>
        </div>
        <div>
            <table class="table table-hover">
                <thead class="thead-inverse">
                <th>Kolejka</th>
                <th>Data spotkania</th>
                <th>Gospodarz</th>
                <th>Gosc</th>
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
                <a href="${contextPath}/tournamentId=${tournament.id}"
                   class="btn btn-primary">Powrot</a>
                </tbody>
            </table>
        </div>
    </div>
    <div class="col-xs-6 col-md-4"></div>
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
    <table id="playerEvent">
        <th>Nazwa</th>
    </table>
    <button id="addEvent" value="aassss">asdfghj</button>
    <div id="eventDialog" >

        <form>
            <div>
                <input id="player" path="name" class="form-control" type="text" name="name" />
            </div>

            <div>
                <select class="form-control" id="selectCategory" path="categoryOfTournament" >
                    <option value="Junior">Junior</option>
                    <option value="Open">Open</option>
                </select>
            </div>


        </form>


    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
