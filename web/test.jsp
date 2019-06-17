<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%
String currentUser = (String) session.getAttribute("currentUser");
System.out.println("MAKE OR BREAK >>>>> " + currentUser);
if (currentUser != null) {
    System.out.println("JSP ++ " + currentUser);
} else {
    currentUser = "";
    System.out.println("No user identified, session invalid");
}
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <p><%=currentUser%></p>
    </body>
</html>
