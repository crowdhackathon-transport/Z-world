<%-- 
    Document   : save_route
    Created on : Jul 19, 2015, 4:52:01 PM
    Author     : Administrator
--%>

<%@page import="gr.hackathon.zworld.model.Region"%>
<%@page import="gr.hackathon.zworld.model.Route"%>
<%@page import="gr.hackathon.zworld.util.ZworldUtils"%>
<%@page import="gr.hackathon.zworld.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%

        User connectedUser = new User();

        if (null == session.getAttribute("userId")) {
            connectedUser.setUserId(-1);
        } else {
            try {
                int userId = Integer.parseInt(session.getAttribute("userId").toString());
                connectedUser = ZworldUtils.getUserById(userId);
            } catch (Exception ex) {
                connectedUser.setUserId(-1);
            }
        }
    %>

    <%
        Route route = new Route();

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            if (request.getParameter("startpoly") != null) {
                String startpoly = request.getParameter("startpoly");
                String endpoly = request.getParameter("endpoly");
                Region startR = new Region();
                startR.setRegionId(Integer.parseInt(startpoly));
                Region endR = new Region();
                endR.setRegionId(Integer.parseInt(endpoly));
                route.setStartRegionId(startR);
                route.setEndRegionId(endR);
                route.setUserId(connectedUser);
                route.setTmstmp("19/7/2015");
                ZworldUtils.addRoute(route);

            }

        }

    %>

    <%@page import="java.util.*" %>

    
    <%response.sendRedirect("./index.jsp");%>
</html>
