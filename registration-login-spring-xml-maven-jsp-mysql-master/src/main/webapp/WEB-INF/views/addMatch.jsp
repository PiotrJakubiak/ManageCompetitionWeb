<%--
  Created by IntelliJ IDEA.
  User: Piotrek
  Date: 30-Nov-16
  Time: 11:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet" >
    <link href="<c:url value="/resources/css/site.css" />" rel="stylesheet">
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
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="http://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript">
        function makeAjax(){
            $.ajax({
                type: "GET",
                url: "http://localhost:8080/createNewTeams",
                cache: false,
                data:'firstName=' + $("#firstName").val() + "&lastName=" + $("#lastName").val(),
                error: function(){
                    alert('Error while request..');

                }
            });
        };
        $( function() {
            var dialog, form,
                    firstName = $( "#firstName" ),
                    lastName = $( "#lastName" ),
                    birthdate = $( "#birthdate" ),
                    position = $( "#position" ),
                    number = $( "#number" ),
            //allFields = $( [] ).add( names ).add( email ).add( password ),
                    tips = $( ".validateTips" );



            function addUser() {
                var valid = true;
                // allFields.removeClass( "ui-state-error" );
                makeAjax();
                if ( valid ) {
                    $( "#players tbody" ).append(  "<tr>" + "<td>" + firstName.val()  + "</td>" + "<td>" + lastName.val()  + "</td>" + "<td>" + birthdate.val()  + "</td>" +
                            "<td>" + position.val()  + "</td>" + "<td>" + number.val()  + "</td>" + "</tr>" + "</tbody>");
                    dialog.dialog( "close" );
                }
                return valid;
            }

            dialog = $( "#dialog-form" ).dialog({
                autoOpen: false,
                height: 450,
                width: 400,
                modal: true,
                buttons: {
                    "Create an account": addUser,
                    Cancel: function() {
                        dialog.dialog( "close" );
                    }
                },
                close: function() {
                    form[ 0 ].reset();
                    // allFields.removeClass( "ui-state-error" );
                }
            });

            form = dialog.find( "form" ).on( "submit", function( event ) {
                event.preventDefault();
                addUser();
            });

            $( "#create-user" ).button().on( "click", function() {
                dialog.dialog( "open" );
            });

        });
        $(document).ready(function() {

            $('#datetimepicker4').datetimepicker({
                format: 'YYYY/MM/DD'
            });
        });
    </script>
</head>
<body>
<header>
    <div class="container">
        <a href="${contextPath}/login" id="home_page"><h1>ManageCompetition</h1></a>
        <nav>
            asdasdas
        </nav>
        <div class="user-info">
            <form method="POST" action="${contextPath}/login" class="form-signin">
                <input name="username" type="text" class="form-control" placeholder="Username"
                       autofocus="true"/>
                <input name="password" type="password" class="form-control" placeholder="Password"/>
                <button class="btn btn-primary" type="submit">Log In</button>
                <br/>
                <span class="error">${error}</span>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <img id="img" src="http://icons.iconseeker.com/ico/application-interface/user-5.ico" alt="user" />

            </form>
        </div>
    </div>
</header>
<div class="container">

    <div class="content">

        Nazwa zespolu:
        <c:out value="${team.name}" />
        Skrocona nazwa:
        <c:out value="${team.shortName}" />
        Email kontaktowy:
        <c:out value="${team.emailContact}" />
        Kategoria wiekowa:
        <c:out value="${team.category}" />

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button id="create-user" class="btn btn-primary" >Add new player</button>

        <table class="table table-striped" id="players">
            <thead>
            <th>Imie</th>
            <th>Nazwisko</th>
            <th>Data urodzenia</th>
            <th>Pozycja</th>
            <th>Numer</th>
            </thead>
            <tbody>

            </tbody>
        </table>



    </div>
    <div id="dialog-form" title="Add new player">
        <p class="validateTips">Wypelnij formularz dotyczacy tworzenia zawodnika.</p>

        <form name="playerForm" method="post">

            <label class="form-control" for="firstName">First Name:</label>
            <input class="form-control" type="text" name="firstName" id="firstName" value="">

            <label class="form-control" for="lastName">Last Name:</label>
            <input class="form-control" type="text" name="lastName" id="lastName" value="">

            <label class="form-control" for="birthdate">Birth day:</label>
            <div class='input-group date' id='datetimepicker4'>

                <input type='text' class="form-control" name="birthdate" id="birthdate" value=""/>
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-time"></span>
                    </span>
            </div>

            <label class="form-control" for="position">Position:</label>
            <select class="form-control" id="position" >
                <option value="Bramkarz">Bramkarz</option>
                <option value="Obronca">Obronca</option>
                <option value="Pomocnik">Pomocnik</option>
                <option value="Napastnik">Napastnik</option>
            </select>


            <label class="form-control" for="number">Number:</label>
            <input class="form-control" type="text" name="number" id="number" value="">


        </form>
    </div>
</div>
</body>
</html>
