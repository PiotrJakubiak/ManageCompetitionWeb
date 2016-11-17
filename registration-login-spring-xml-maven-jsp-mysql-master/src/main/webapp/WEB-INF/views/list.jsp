<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Piotrek
  Date: 16-Nov-16
  Time: 8:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

    <table align="left" style="padding-left: 300px;">
        <tr>
            <td
                    style="font-family: 'arial'; font-size: 16px; font-weight: bold;">Lista turniejow</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <table class="border" cellpadding="10">
                    <tr bgcolor="#99CCFF">
                        <th class="th">ID</th>
                        <th class="th">Nazwa</th>
                    </tr>

                    <c:out value="${tournament.id}" /></td>
                    <c:out value="${tournament.name}" /></td>

                </table>
            </td>
        </tr>

        <tr align="center">
            <td><input type="submit" value="Stworz nowy turniej" /></td>
        </tr>
    </table>

</body>
</html>
