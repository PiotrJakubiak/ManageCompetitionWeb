<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
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
</head>
<body>
<jsp:include page="header.jsp" />
<div class="row">
    <div class="col-xs-6 col-md-4"></div>
    <div class="col-xs-6 col-md-4">
        <h2>Wysyłanie wiadomości do uczestnika turnieju</h2>
        <form:form method="post" modelAttribute="emailDTO" action="sendMessage">
            <div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <td><input path="id" type="text" name="id" size="65" value="${emailDTO.id}" readonly style="display: none"/></td>
            </div>
            <div>
                <label>Temat:</label>
            </div>
            <div>
                <input path="subject" type="text" class="form-control" name="subject" size="65" />
            </div>
            <div>
                <label>Treść wiadomości:</label>
            </div>
            <div>
                <textarea path="text" class="form-control" cols="50" rows="10" name="text"></textarea>
            </div>
            <div>
                <input type="submit" class="btn btn-primary" value="Wyslij wiadomość" />
                <a href="${contextPath}/welcome" class="btn btn-primary">Wroc</a>
            </div>



        </form:form>
    </div>
    <div class="col-xs-6 col-md-4"> </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>