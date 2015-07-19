<%-- 
    Document   : test
    Created on : 17 Ιουλ 2015, 7:23:08 μμ
    Author     : Acer
--%>

<%@page import="com.vividsolutions.jts.geom.Coordinate"%>
<%@page import="com.vividsolutions.jts.geom.LineString"%>
<%@page import="gr.hackathon.zworld.model.Comments"%>
<%@page import="java.util.List"%>
<%@page import="gr.hackathon.zworld.model.Route"%>
<%@page import="gr.hackathon.zworld.model.User"%>
<%@page import="gr.hackathon.zworld.util.ZworldUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>

        <%
            User user = new User();
            try {
          /*      
                user = ZworldUtils.getUserById(1);
                out.print(user.getEmail());
                out.print("<br>");
                List<Comments> commentsList = ZworldUtils.getAllComments();
                out.print(commentsList.get(0).getDescription());
                
                out.print("<br>");
                List<Route> routeList = ZworldUtils.getAllRouteList();
                out.print(routeList.get(0).getStops());
                out.print("<br>");
                List<Route> userRouteList = ZworldUtils.getAllRouteByUserId(1);
                out.print(userRouteList.get(0).getStops().getCoordinates()[0]);
            */   
                
                Route route=ZworldUtils.getRouteById(4);
                LineString lineString=route.getStops();
                for(Coordinate coo:lineString.getCoordinates()){
        		System.out.println(coo);//suntetagmenes kathe shmeiou ths diadromhs
        		System.out.println(coo.x);
        		System.out.println(coo.y);
        		System.out.println("-------");
        	}
            } catch (Exception ex) {
                out.print("Exception!"+ex);
            }
            
        %>
    </body>
</html>
