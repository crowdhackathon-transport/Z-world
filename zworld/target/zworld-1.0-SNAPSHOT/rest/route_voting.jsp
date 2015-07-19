<%-- 
    Document   : route_voting
    Created on : 19 Ιουλ 2015, 12:29:55 πμ
    Author     : Acer
--%>

<%@page import="gr.hackathon.zworld.model.User"%>
<%@page import="gr.hackathon.zworld.model.RouteVotes"%>
<%@page import="java.util.List"%>
<%@page import="gr.hackathon.zworld.util.ZworldUtils"%>
<%@page import="gr.hackathon.zworld.model.Route"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

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

    Route route = new Route();
    int positive = 0;
    int negative = 0;
    RouteVotes conUserVote = new RouteVotes();
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        if (request.getParameter("routeId") != null && request.getParameter("clicked") != null) {
            String routeId = request.getParameter("routeId");
            String clicked = request.getParameter("clicked");
            route = ZworldUtils.getRouteById(Integer.parseInt(routeId));
            List routeVotesList = route.getRouteVotesList();
            conUserVote.setRouteVotesId(-1);
            for (int i = 0; i < routeVotesList.size(); i++) {
                RouteVotes routeVote = (RouteVotes) routeVotesList.get(i);
                if (routeVote.getVoteStatus() == 1) {
                    positive++;
                } else if (routeVote.getVoteStatus() == -1) {
                    negative++;
                }
                if (routeVote.getUserId().getUserId() == connectedUser.getUserId()) {
                    conUserVote = routeVote;
                }
            }
            if (connectedUser.getUserId() != -1) {
                if (clicked.equalsIgnoreCase("positive_vote")) {
                    //update
                    if (conUserVote.getRouteVotesId() != -1) {
                        conUserVote.setRouteId(route);
                        conUserVote.setUserId(connectedUser);
                        ZworldUtils.updateRouteVotes(conUserVote);
                        if (conUserVote.getVoteStatus() == 1) {
                            conUserVote.setVoteStatus(0);
                            ZworldUtils.updateRouteVotes(conUserVote);
                        } else {
                            conUserVote.setVoteStatus(1);
                            ZworldUtils.updateRouteVotes(conUserVote);
                        }
                    } else {//insert
                        RouteVotes routeVote = new RouteVotes();
                        routeVote.setRouteId(route);
                        routeVote.setUserId(connectedUser);
                        routeVote.setVoteStatus(1);
                        ZworldUtils.addRouteVotes(routeVote);
                    }
                } else if (clicked.equalsIgnoreCase("negative_vote")) {
                    //update
                    if (conUserVote.getRouteVotesId() != -1) {
                        conUserVote.setRouteId(route);
                        conUserVote.setUserId(connectedUser);
                        if (conUserVote.getVoteStatus() == -1) {
                            conUserVote.setVoteStatus(0);
                            ZworldUtils.updateRouteVotes(conUserVote);
                        } else {
                            conUserVote.setVoteStatus(-1);
                            ZworldUtils.updateRouteVotes(conUserVote);
                        }
                    } else {//insert
                        RouteVotes routeVote = new RouteVotes();

                        routeVote.setRouteId(route);
                        routeVote.setUserId(connectedUser);
                        routeVote.setVoteStatus(-1);
                        ZworldUtils.addRouteVotes(routeVote);
                    }
                }
            }
            positive = 0;
            negative = 0;
            conUserVote.setRouteVotesId(-1);
            route = ZworldUtils.getRouteById(Integer.parseInt(routeId));
            routeVotesList = route.getRouteVotesList();
            for (int i = 0; i < routeVotesList.size(); i++) {
                RouteVotes routeVote = (RouteVotes) routeVotesList.get(i);
                if (routeVote.getVoteStatus() == 1) {
                    positive++;
                } else if (routeVote.getVoteStatus() == -1) {
                    negative++;
                }
                if (routeVote.getUserId().getUserId() == connectedUser.getUserId()) {
                    conUserVote = routeVote;
                }
            }
        }
    }


%>
<div class="info-box bg-green" style="cursor: pointer;" onclick="ajaxGetVotes('positive_vote')">
    <span class="info-box-icon"><a href="#" style="color: #FFF"><i class="fa fa-thumbs-o-up"></i></a></span>
    <div class="info-box-content">
        <span class="info-box-text">Likes</span>
        <span class="info-box-number"><%=positive%></span>
        <%
            if (conUserVote.getRouteVotesId() != -1) {
                if (conUserVote.getVoteStatus() == 1) {
        %>
        <span class="info-box-text"><strong>Liked</strong></span>

        <%                               }
            }
        %>
    </div><!-- /.info-box-content -->
</div><!-- /.info-box -->

<div class="info-box bg-red" style="cursor: pointer;" onclick="ajaxGetVotes('negative_vote')">
    <span class="info-box-icon"><a href="#" style="color: #FFF"><i class="fa fa-thumbs-o-down"></i></a></i></span>
    <div class="info-box-content">
        <span class="info-box-text">Dislikes</span>
        <span class="info-box-number"><%=negative%></span>
        <%
            if (conUserVote.getRouteVotesId() != -1) {
                if (conUserVote.getVoteStatus() == -1) {
        %>
        <span class="info-box-text"><strong>Disliked</strong></span>

        <%                               }
            }
        %>
    </div><!-- /.info-box-content -->
</div><!-- /.info-box -->
