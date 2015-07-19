<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.util.*" %>

<%session.invalidate();%>
You have logged out. <%response.sendRedirect("../index.jsp");%>