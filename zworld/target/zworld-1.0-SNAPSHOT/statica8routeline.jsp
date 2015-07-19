<%-- 
    Document   : statica8routeline
    Created on : Jul 19, 2015, 11:20:54 AM
    Author     : panos
--%>

<<%@page import="gr.hackathon.zworld.model.Comments"%>
<%@page import="java.util.List"%>
<%@page import="com.vividsolutions.jts.geom.Coordinate"%>
<%@page import="com.vividsolutions.jts.geom.LineString"%>
<%@page import="gr.hackathon.zworld.util.ZworldUtils"%>
<%@page import="gr.hackathon.zworld.model.Route"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hackathon A8 static route</title>
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
                height: 400px;
                
            }
            
            
            
        </style>
        
     
        <script type="text/javascript">


window.twttr = (function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0],
    t = window.twttr || {};
  if (d.getElementById(id)) return t;
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
        
                var map = new L.Map('map', {center: new L.LatLng(38.04103851318359400000,23.75158500671386700000), zoom: 12});
                var googleLayer = new L.Google('ROADMAP');
                map.addLayer(googleLayer);
                
               
                


                
control=L.Routing.control({
    waypoints: [
L.latLng(37.98890686035156200000,23.72980308532714800000),
L.latLng(37.99036788940429700000,23.73118782043457000000),
L.latLng(37.99399566650390600000,23.73207473754882800000),
L.latLng(37.99707794189453100000,23.73288345336914100000),
L.latLng(37.99874496459960900000,23.73324203491210900000),
L.latLng(38.00218200683593800000,23.73408317565918000000),
L.latLng(38.00516891479492200000,23.73485946655273400000),
L.latLng(38.00804519653320300000,23.73516654968261700000),
L.latLng(38.00914382934570300000,23.73519706726074200000),
L.latLng(38.01082992553710900000,23.73524856567382800000),
L.latLng(38.01314544677734400000,23.73543357849121100000),
L.latLng(38.01645278930664100000,23.73554801940918000000),
L.latLng(38.01841735839843800000,23.73567771911621100000),
L.latLng(38.02081298828125000000,23.73777580261230500000),
L.latLng(38.02329635620117200000,23.74037551879882800000),
L.latLng(38.02528381347656300000,23.74195289611816400000),
L.latLng(38.03065872192382800000,23.74351882934570300000),
L.latLng(38.03300476074218800000,23.74478530883789100000),
L.latLng(38.03600311279296900000,23.74863815307617200000),
L.latLng(38.03767395019531300000,23.75026321411132800000),
L.latLng(38.04103851318359400000,23.75158500671386700000),
L.latLng(38.04228591918945300000,23.75326728820800800000),
L.latLng(38.04445648193359400000,23.75605201721191400000),
L.latLng(38.04519653320312500000,23.75725746154785200000),
L.latLng(38.04639053344726600000,23.75903129577636700000),
L.latLng(38.04848861694335900000,23.76181602478027300000),
L.latLng(38.04969787597656300000,23.76383018493652300000),
L.latLng(38.05167007446289100000,23.76645660400390600000),
L.latLng(38.05389022827148400000,23.76870727539062500000),
L.latLng(38.05527877807617200000,23.76978492736816400000),
L.latLng(38.05699539184570300000,23.77139854431152300000),
L.latLng(38.05978393554687500000,23.77298545837402300000),
L.latLng(38.06127166748046900000,23.77364158630371100000),
L.latLng(38.06344985961914100000,23.77575492858886700000),
L.latLng(38.06322097778320300000,23.77935791015625000000),
L.latLng(38.06306076049804700000,23.78017997741699200000),
L.latLng(38.06161499023437500000,23.78319358825683600000),
L.latLng(38.05997848510742200000,23.78614997863769500000),
L.latLng(38.05935287475585900000,23.78857994079589800000),
L.latLng(38.05913162231445300000,23.79049682617187500000),
L.latLng(38.05921936035156300000,23.79401779174804700000),
L.latLng(38.06000900268554700000,23.79686546325683600000),
L.latLng(38.05828475952148400000,23.80055236816406300000),
L.latLng(38.05696487426757800000,23.80325698852539100000),
L.latLng(38.05561828613281200000,23.80247497558593700000),
L.latLng(38.05379486083984400000,23.80571556091308600000),
L.latLng(38.05278396606445300000,23.80916213989257800000),
L.latLng(38.05162048339843700000,23.80989456176757800000),
L.latLng(38.04888534545898400000,23.80783843994140600000),
L.latLng(38.04663085937500000000,23.80727386474609400000),
L.latLng(38.04484558105468700000,23.80536460876464800000),
L.latLng(38.04376983642578100000,23.80430793762207000000),
L.latLng(38.04207229614257800000,23.80261421203613300000),
L.latLng(38.03977203369140600000,23.80126380920410200000),
L.latLng(38.03818130493164100000,23.79801940917968800000),
L.latLng(38.03988647460937500000,23.79447174072265600000),
L.latLng(38.03900146484375000000,23.79330062866210900000)


    ]
}).addTo(map);
        var already_route_nodes="";
        console.log("h uparxousa diadromh periexei:");
        for(var i=0;i<control.getWaypoints().length;i++){
		already_route_nodes=already_route_nodes+control.getWaypoints()[i].latLng.lat+"//"+control.getWaypoints()[i].latLng.lng+"/*/";
		console.log(i+")  "+control.getWaypoints()[i].latLng);
        }
                
        function routechanged(e){
            console.log("epiasa to event");
            //document.getElementById('route_nodes').value="";
            var route_nodes="";
            for(var i=0;i<e.waypoints.length;i++){
		route_nodes=route_nodes+e.waypoints[i].latLng.lat+"//"+e.waypoints[i].latLng.lng+"/*/";
		console.log(i+")  "+e.waypoints[i].latLng);
		
            }
	//document.getElementById('route_nodes').value=route_nodes
            console.log(route_nodes);
        }    
        control.on('waypointschanged',routechanged);        
               
        var x = document.createElement("INPUT");
        x.setAttribute("type", "hidden");
        x.setAttribute("id","test");
        x.setAttribute("value","zlapi");
        
        
        //document.getElementById("test").value="testaki";    
                
        }

            
              
                

            google.maps.event.addDomListener(window, 'load', init);
            
            
	  
          
  

          
          
            
            
            
            
            
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
                            Διαδρομή - Διαδρομή - Διαδρομή - Διαδρομή - Διαδρομή - Διαδρομή - Διαδρομή
                            <small>Κενό</small>
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

                                    <div class="box-body">
                                        <div class="info-box bg-green">
                                            <span class="info-box-icon"><a href="#" style="color: #FFF"><i class="fa fa-thumbs-o-up"></i></a></span>
                                            <div class="info-box-content">
                                                <span class="info-box-text">Likes</span>
                                                <span class="info-box-number">41,410</span>


                                            </div><!-- /.info-box-content -->
                                        </div><!-- /.info-box -->

                                        <div class="info-box bg-red">
                                            <span class="info-box-icon"><a href="#" style="color: #FFF"><i class="fa fa-thumbs-o-down"></i></a></i></span>
                                            <div class="info-box-content">
                                                <span class="info-box-text">Dislikes</span>
                                                <span class="info-box-number">41,410</span>

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
                                        <a href="http://www.facebook.com/share.php?u=http://www.naftemporiki.gr" target="popup" onclick="window.open('http://www.facebook.com/share.php?u=http://www.naftemporiki.gr','name','width=600,height=400')" class="btn btn-block btn-social btn-facebook">
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
                                        <!-- chat item -->
                                        <div class="item">
                                            <img src="dist/img/user4-128x128.jpg" alt="user image" class="online"/>
                                            <p class="message">
                                                <a href="#" class="name">
                                                    <small class="text-muted pull-right"><i class="fa fa-clock-o"></i> 2:15</small>
                                                    Mike Doe
                                                </a>
                                                I would like to meet you to discuss the latest news about the arrival of the new theme. They say it is going to be one the best themes on the market
                                                <br>
                                                <span id="label label-success" class="label label-success"><i class="icon fa fa-thumbs-up"></i> 10</span> 
                                                <span class="label label-danger"><i class="icon fa  fa-thumbs-down"></i> 3</span>         
                                            </p>
                                        </div><!-- /.item -->
                                        <%
                                            List<Comments> commentsList= ZworldUtils.getCommentsByRouteId(3);
                                            for(Comments comment:commentsList){
                                            %>
                                            <div class="item">
                                            <img src="dist/img/user4-128x128.jpg" alt="user image" class="online"/> 
                                            <p class="message">
                                                
                                                <span class="name">
                                                    <small class="text-muted pull-right"><i class="fa fa-clock-o"></i> <% out.print(comment.getTmstmp()); %></small>
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
                                        %> 
                    
                                        
                                     
                                    </div><!-- /.chat -->
                                    <div class="box-footer">
                                        <div class="input-group">
                                            <input class="form-control" placeholder="Type message..."/>
                                            <div class="input-group-btn">
                                                <button class="btn btn-success"><i class="fa fa-plus"></i></button>
                                            </div>
                                        </div>
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
