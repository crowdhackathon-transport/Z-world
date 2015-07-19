<%-- 
    Document   : test-show-map
    Created on : Jul 18, 2015, 1:39:29 PM
    Author     : panos
--%>

<%@page import="gr.hackathon.zworld.model.User"%>
<%@page import="gr.hackathon.zworld.model.Comments"%>
<%@page import="java.util.List"%>
<%@page import="com.vividsolutions.jts.geom.Coordinate"%>
<%@page import="com.vividsolutions.jts.geom.LineString"%>
<%@page import="gr.hackathon.zworld.util.ZworldUtils"%>
<%@page import="gr.hackathon.zworld.model.Route"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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

    if ("GET".equalsIgnoreCase(request.getMethod())) {
        if (request.getParameter("routeId") != null) {
            String routeId = request.getParameter("routeId");
            route = ZworldUtils.getRouteById(Integer.parseInt(routeId));
        }
    }
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (request.getParameter("routeId") != null) {
            String routeId = request.getParameter("routeId");
            route = ZworldUtils.getRouteById(Integer.parseInt(routeId));
        }
        if (request.getParameter("comment") != null) {
            String comment = request.getParameter("comment");
            Comments commentObj = new Comments();
            commentObj.setRouteId(route.getRouteId());
            commentObj.setUserId(connectedUser);
            commentObj.setDescription(comment); 
            commentObj.setTmstmp("19/07/2015");
            ZworldUtils.addCommentOnRoute(commentObj);
        }
    }


%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hackathon</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- Bootstrap 3.3.4 -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />    
        <!-- FontAwesome 4.3.0 -->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons 2.0.0 -->
        <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />    
        <!-- Theme style -->
        <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
        <!-- AdminLTE Skins. Choose a skin from the css/skins 
             folder instead of downloading all of them to reduce the load. -->
        <link href="dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
        <!-- iCheck -->
        <link href="plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />
        <!-- Morris chart -->
        <link href="plugins/morris/morris.css" rel="stylesheet" type="text/css" />
        <!-- jvectormap -->
        <link href="plugins/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <!-- Date Picker -->
        <link href="plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
        <!-- Daterange picker -->
        <link href="plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <!-- bootstrap wysihtml5 - text editor -->
        <link href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="libraries/mystyle.css">
        <link rel="stylesheet" href="libraries/leaflet-routing-machine.css" />
        <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.css" />


        <script src="libraries/leaflet-routing-machine.min.js"></script>
        <script src="libraries/leaflet.js"></script>
        <script src="libraries/leaflet-routing-machine.js"></script>
        <script src="http://matchingnotes.com/javascripts/leaflet-google.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script type="text/javascript" src="//www.google.com/jsapi?autoload={'modules':[{name:'maps',version:3,other_params:''}]}"></script>

        <style type="text/css">
            #map {
                height: 438px;
            }
        </style>


        <script type="text/javascript">


            window.twttr = (function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0],
                        t = window.twttr || {};
                if (d.getElementById(id))
                    return t;
                js = d.createElement(s);
                js.id = id;
                js.src = "https://platform.twitter.com/widgets.js";
                fjs.parentNode.insertBefore(js, fjs);

                t._e = [];
                t.ready = function(f) {
                    t._e.push(f);
                };

                return t;
            }(document, "script", "twitter-wjs"));




            function init() {
                var map = new L.Map('map', {center: new L.LatLng(37.9841349, 23.7280425), zoom: 1});
                var googleLayer = new L.Google('ROADMAP');
                map.addLayer(googleLayer);
                control = L.Routing.control({
                    waypoints: [
            <%
//                int routeId = 5;//getParameter    
                try {
                    LineString lineString = route.getStops();
                    for (int i = 0; i < lineString.getCoordinates().length; i++) {
                        Coordinate coo = lineString.getCoordinates()[i];
                        if (i == lineString.getCoordinates().length - 1) {
                            out.println("L.latLng(" + coo.x + "," + coo.y + ")");
                        } else {
                            out.println("L.latLng(" + coo.x + "," + coo.y + "),");
                        }

                    }
                } catch (Exception ex) {
                    out.println("L.latLng(" + route.getStartRegionId().getCenter().getCoordinate().x + "," + route.getStartRegionId().getCenter().getCoordinate().y + "),");
                    out.println("L.latLng(" + route.getEndRegionId().getCenter().getCoordinate().x + "," + route.getEndRegionId().getCenter().getCoordinate().y + ")");
                }
            %>
                    ]
                }).addTo(map);

            }
            google.maps.event.addDomListener(window, 'load', init);

            $(window).load(function() {
                ajaxGetVotes("none");
            });

            function ajaxGetVotes(clicked) {
                var xmlHttp;
                if (window.XMLHttpRequest) {
                    xmlHttp = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                } else {
                    document.write("browser not supported");
                }
                xmlHttp.onreadystatechange = function() {
                    if (xmlHttp.readyState === 4) {
                        document.getElementById("routeVotingDiv").innerHTML = xmlHttp.responseText;
                    }
                };
                xmlHttp.open("POST", "rest/route_voting.jsp", true);
                xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xmlHttp.send("routeId=" + <%=route.getRouteId()%> + "&clicked=" + clicked);
            }


        </script>


    </head>
    <!-- ADD THE CLASS layout-top-nav TO REMOVE THE SIDEBAR. -->
    <body class="skin-blue-light layout-top-nav">
        <div class="wrapper">

            <header class="main-header">               
                <nav class="navbar navbar-static-top">
                    <div class="container">
                        <div class="navbar-header">
                            <a href="index.jsp" class="navbar-brand"><b>ZWorld</b></a>
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
                                <i class="fa fa-bars"></i>
                            </button>
                        </div>


                        <!-- Navbar Right Menu -->
                        <div class="navbar-custom-menu">
                            <ul class="nav navbar-nav">

                                <%
                                    if (connectedUser.getUserId() != -1) {

                                %>
                                <!-- User Account Menu -->
                                <li class="dropdown user user-menu">
                                    <!-- Menu Toggle Button -->
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                        <!-- The user image in the navbar-->
                                        <img src="img/icon-user.png" class="user-image" alt="User Image"/>
                                        <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                        <span class="hidden-xs"><%=connectedUser.getName()%> <%=connectedUser.getSurname()%></span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <!-- The user image in the menu -->
                                        <li class="user-header">
                                            <img src="img/icon-user.png" class="img-circle" alt="User Image" />
                                            <p>
                                                <%=connectedUser.getName()%> <%=connectedUser.getSurname()%>
                                            </p>
                                        </li>
                                        <!-- Menu Body -->
                                        <li class="user-body">
                                            <div class="col-xs-6 text-center">
                                                <a href="#">Διαδρομές</a>
                                            </div>
                                            <div class="col-xs-6 text-center">
                                                <a href="#">Ενημερώσεις</a>
                                            </div>
                                        </li>
                                        <!-- Menu Footer-->
                                        <li class="user-footer">
                                            <div class="pull-left">
                                                <a href="#" class="btn btn-default btn-flat">Προφίλ</a>
                                            </div>
                                            <div class="pull-right">
                                                <a href="rest/logout.jsp" class="btn btn-default btn-flat">Αποσύνδεση</a>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                                <%
                                } else {
                                %>
                                <!-- User Account Menu -->
                                <li class="dropdown user user-menu">
                                    <!-- Menu Toggle Button -->
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                        <!-- The user image in the navbar-->
                                        <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                        <span class=""><b><i class="icon fa fa-sign-in"></i> Σύνδεση</b></span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li class="user-header" style="height: 60px;">
                                            <p>Σύνδεση</p>
                                        </li>
                                        <!-- Menu Body -->
                                        <li class="user-body">
                                            <form action="login.jsp" method="post">
                                                <div class="form-group has-feedback">
                                                    <input name="email" type="email" class="form-control" placeholder="Email"/>
                                                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                                                </div>
                                                <div class="form-group has-feedback">
                                                    <input name="password" type="password" class="form-control" placeholder="Password"/>
                                                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-8">    

                                                    </div><!-- /.col -->
                                                    <div class="col-xs-4">
                                                        <button style="padding: 6px 6px" type="submit" class="btn btn-primary btn-block btn-flat">Σύνδεση</button>
                                                    </div><!-- /.col -->
                                                </div>
                                            </form>
                                        </li>
                                        <li class="user-footer" style="color: #FFF;">
                                            <div class="social-auth-links text-center"  >
                                                <a href="#" class="btn btn-block btn-social btn-facebook btn-flat" ><i class="fa fa-facebook"></i> Sign in using Facebook</a>
                                            </div><!-- /.social-auth-links -->
                                            <a class="text-center" href="test-register.html">
                                                Register a new membership
                                            </a>
                                        </li>
                                        <!-- Menu Footer-->

                                    </ul>
                                </li>

                                <%                                    }
                                %>
                            </ul>
                        </div><!-- /.navbar-custom-menu -->
                    </div><!-- /.container-fluid -->
                </nav>
            </header>
            <!-- Full Width Column -->
            <div class="content-wrapper">
                <div class="container">
                    <section class="content-header">
                        <h1>
                            <%=route.getStartRegionId().getName()%> - <%=route.getEndRegionId().getName()%>
                        </h1>
                        <br>
                    </section>
                    <!-- Main content -->
                    <section class="content">
                        <div class="row">
                            <div class="col-md-9">
                                <div class="box box-success">
                                    <div class="box-header">
                                        <i class="fa fa-map-marker"></i>
                                        <h3 class="box-title">Χάρτης προτεινόμενης διαδρομής</h3>
                                    </div>

                                    <div class="box-body">
                                        <div id="map"></div>
                                    </div><!-- /.box-body -->
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="box box-success">
                                    <div class="box-header">
                                        <i class="fa fa-bar-chart"></i>
                                        <h3 class="box-title">Αξιολόγηση διαδρομής</h3>
                                    </div>

                                    <div class="box-body" id="routeVotingDiv">
                                        <div class="info-box bg-green">
                                            <span class="info-box-icon"><a href="#" style="color: #FFF"><i class="fa fa-thumbs-o-up"></i></a></span>
                                            <div class="info-box-content">
                                                <span class="info-box-text">Likes</span>
                                                <span class="info-box-number">-</span>
                                            </div><!-- /.info-box-content -->
                                        </div><!-- /.info-box -->

                                        <div class="info-box bg-red">
                                            <span class="info-box-icon"><a href="#" style="color: #FFF"><i class="fa fa-thumbs-o-down"></i></a></i></span>
                                            <div class="info-box-content">
                                                <span class="info-box-text">Dislikes</span>
                                                <span class="info-box-number">-</span>

                                            </div><!-- /.info-box-content -->
                                        </div><!-- /.info-box -->

                                    </div><!-- /.box-body -->
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="box box-primary">
                                    <div class="box-header">
                                        <i class="fa fa-retweet"></i>
                                        <h3 class="box-title">Αναδημοσίευση</h3>
                                    </div>

                                    <div class="box-body">
                                        <a href="http://www.facebook.com/share.php?u=http://localhost:8080/zworld/test-show-map.jsp?routeId=<%=route.getRouteId()%>" target="popup" onclick="window.open('http://www.facebook.com/share.php?u=http://localhost:8080/zworld/test-show-map.jsp?routeId=<%=route.getRouteId()%>', 'name', 'width=600,height=400')" class="btn btn-block btn-soce.getRouteId()%>" target="popup" onclick="window.open('http://www.facebook.com/share.php?u=http://localhost:8080/zworld/test-show-map.jsp?routeId=<%=route.getRouteId()%>', 'name', 'width=ial btn-facebook">
                                            <i class="fa fa-facebook"></i> Share
                                        </a>
                                    </div><!-- /.box-body -->
                                    <div class="box-body">
                                        <a href="https://twitter.com/intent/tweet?text=Transport OP" class="btn btn-block btn-social btn-twitter">
                                            <i class="fa fa-twitter"></i> Tweet!
                                        </a>
                                    </div><!-- /.box-body -->

                                    <div class="box-body">
                                        <div class="addthis_sharing_toolbox"></div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-9">
                                <!-- Chat box -->
                                <div class="box box-success">
                                    <div class="box-header">
                                        <i class="fa fa-comments-o"></i>
                                        <h3 class="box-title">Η γνώμη του κόσμου</h3>
                                    </div>
                                    <div class="box-body chat" id="chat-box">
                                        
                                        <%
                                            try {
                                                List<Comments> commentsList = ZworldUtils.getCommentsByRouteId(route.getRouteId());
                                                for (Comments comment : commentsList) {
                                        %>
                                        <div class="item">
                                            <img src="dist/img/user4-128x128.jpg" alt="user image" class="online"/> 
                                            <p class="message">

                                                <span class="name">
                                                    <small class="text-muted pull-right"><i class="fa fa-clock-o"></i> <% out.print(comment.getTmstmp());%></small>
                                                    <%
                                                        //  onoma user
                                                        out.print(comment.getUserId().getName() + " " + comment.getUserId().getSurname());
                                                    %>       
                                                </span>
                                                <%
                                                    // sxolio user
                                                    out.print(comment.getDescription());
                                                %>        
                                                <br>
                                                <span class="label label-success"><i class="icon fa fa-thumbs-up"></i> 10</span> 
                                                <span class="label label-danger"><i class="icon fa  fa-thumbs-down"></i> 3</span>         
                                            </p>
                                        </div>
                                        <%
                                                }
                                            } catch (Exception ex) {
                                            }
                                        %> 



                                    </div><!-- /.chat -->
                                    <div class="box-footer">
                                        <form action="test-show-map.jsp?routeId=<%=route.getRouteId()%>" method="POST">
                                            <div class="input-group">

                                                <input name="comment" class="form-control" placeholder="Type message..."/>
                                                <div class="input-group-btn">
                                                    <button type="submit" class="btn btn-success"><i class="fa fa-plus"></i></button>
                                                </div>

                                            </div>
                                        </form>
                                    </div>
                                </div><!-- /.box (chat box) -->
                            </div>
                        </div><!-- /.box (chat box) -->
                    </section><!-- /.content -->
                </div><!-- /.container -->
                <!--                  -->



            </div><!-- /.content-wrapper -->
            <footer class="main-footer">
                <div class="container">
                    <strong>Copyright &copy; 2014-2015 <a href="test-main.html">Hackathon</a>.</strong> All rights reserved.
                </div><!-- /.container -->
            </footer>
        </div><!-- ./wrapper -->

        <!-- jQuery 2.1.4 -->
        <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
        <!-- jQuery UI 1.11.4 -->
        <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" type="text/javascript"></script>
        <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
        <script>
            $.widget.bridge('uibutton', $.ui.button);
        </script>
        <!-- Bootstrap 3.3.2 JS -->
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>    
        <!-- Morris.js charts -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>

        <!-- Sparkline -->
        <script src="plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
        <!-- jvectormap -->
        <script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
        <script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
        <!-- jQuery Knob Chart -->
        <script src="plugins/knob/jquery.knob.js" type="text/javascript"></script>
        <!-- daterangepicker -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js" type="text/javascript"></script>
        <script src="plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <!-- datepicker -->
        <script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
        <!-- Bootstrap WYSIHTML5 -->
        <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
        <!-- Slimscroll -->
        <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <!-- ChartJS 1.0.1 -->
        <script src="plugins/chartjs/Chart.min.js" type="text/javascript"></script>
        <!-- FastClick -->
        <script src='plugins/fastclick/fastclick.min.js'></script>
        <!-- AdminLTE App -->
        <script src="dist/js/app.min.js" type="text/javascript"></script>    
        <!-- Go to www.addthis.com/dashboard to customize your tools -->
        <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-55aa3dd889d4e0f4" async="async"></script>

        <!-- AdminLTE for demo purposes -->
        <script src="dist/js/demo.js" type="text/javascript"></script>
    </body>
</html>
