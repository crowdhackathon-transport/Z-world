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

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Polygons</title>
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
        <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.css" /> 
        <script src="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.js"></script>
        <script src="http://maps.google.com/maps/api/js?v=3.2&sensor=false"></script>
        <script src="http://matchingnotes.com/javascripts/leaflet-google.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

        <link rel="stylesheet" href="http://leaflet.github.io/Leaflet.label/leaflet.label.css" />
        <script src="http://leaflet.github.io/Leaflet.label/leaflet.label.js"></script> 

        <style type="text/css">
            #map {
                height: 500px;

            }
        </style>






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

                        </h1>
                        <br>
                    </section>
                    <!-- Main content -->
                    <section class="content">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="box box-success">
                                    <div class="box-header">
                                        <i class="fa fa-map-marker"></i>
                                        <h3 class="box-title">Polygons</h3>
                                    </div>

                                    <div class="box-body">
                                        <div id="map"></div>
                                        <br>
                                        <br>
                                        <form action="save_route.jsp" method="post">
                                            <input name="startpoly" type="text" class="form-control" placeholder="Start Polygon Id"/>
                                            <br>
                                            <input name="endpoly" type="text" class="form-control" placeholder="End Polygon Id"/>
                                            <br>
                                            <button type="submit" class="btn btn-primary btn-block btn-flat">Δημιουργία</button>

                                        </form>
                                    </div><!-- /.box-body -->
                                </div>
                            </div>


                        </div>
                        <br>

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

        <script type="text/javascript">


            var map = new L.Map('map', {center: new L.LatLng(37.9841349, 23.7280425), zoom: 16, minZoom: 11});
            var googleLayer = new L.Google('ROADMAP');
            map.addLayer(googleLayer);

            var southWest = new L.LatLng(37.85425428219824, 23.545074462890625);
            var northEast = new L.LatLng(38.118892293285704, 23.952255249023438);

            var bounds = new L.LatLngBounds(southWest, northEast);
            map.setMaxBounds(bounds);


            polygon_ids = new Array();
            var polygons;

            $(document).ready(function () {
                //start ajax request
                $.ajax({
                    url: "libraries/polygon.json",
                    //force to handle it as text
                    dataType: "text",
                    success: function (data) {

                        //data downloaded so we call parseJSON function 
                        //and pass downloaded data
                        polygons = $.parseJSON(data);
                        //now json variable contains data in json format
                        //let's display a few items
                        var geoJson = L.geoJson(polygons, {
                            style: function (feature) {
                                switch (feature.properties.party) {
                                    case 'Republican':
                                        return {color: "green"};
                                    case 'Democrat':
                                        return {color: "black"};
                                }
                            },
                            onEachFeature: onEachFeature
                        }).addTo(map);

                        geoJson.eachLayer(function (added_polygons) {
                            polygon_ids.push(added_polygons._leaflet_id);

                        });
                    }

                });
            });


            var a;

            function onEachFeature(feature, layer) {

                layer.on({
                    click: highlightFeature,
                    mouseover: hoverFeature
                });
                //console.log(feature.getBounds().getCenter());
//	console.log(feature);
//	console.log(feature._latlngs);
//	console.log(layer);
//	console.log(layer);

//        text=layer.leaflet_id;
                //       text="2312312";
                a = layer;
//	layer.bindLabel(text).addTo(map);
                /*
                 var getCentroid = function (arr) { 
                 return arr.reduce(function (x,y) {
                 return [x[0] + y[0]/arr.length, x[1] + y[1]/arr.length] 
                 }, [0,0]) 
                 }
                 
                 centerL20 = getCentroid(layer._latlngs);
                 console.log(centerL20);
                 */}


            function highlightFeature(e) {
                console.log("patithika");
                //console.log(e._latlngs);	
                //console.log(this);
                //console.log(this._latLngs);
                putColorToTheRest(this._leaflet_id);

            }
//var a=layer;

            function hoverFeature(e) {
                a = this._leaflet_id + 1;
                text = "" + a;
                this.bindLabel(text).addTo(map);

            }




            function putColorToTheRest(polygonId) {
                console.log("irtha edw kai exw id" + polygonId);

                var rand;
                for (var i = 0; i < polygon_ids.length; i++) {

                    if (polygon_ids[i] != polygonId) {//den einai auto pou patithike
                        rand = (polygonId + i) % 3;
                        if (rand == 0) {
                            map._layers[polygon_ids[i]].setStyle({color: "yellow"});
                        } else if (rand == 1) {
                            map._layers[polygon_ids[i]].setStyle({color: "green"});
                        } else if (rand == 2) {
                            map._layers[polygon_ids[i]].setStyle({color: "red"});
                        } else {
                        }
                    } else {//einai auto pou patithike: to afhnoume ws exei
                        map._layers[polygon_ids[i]].setStyle({color: "blue"});
                    }
                }

            }

        </script>





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
