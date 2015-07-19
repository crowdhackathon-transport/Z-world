
<%@page import="gr.hackathon.zworld.model.Comments"%>
<%@page import="gr.hackathon.zworld.model.RouteVotes"%>
<%@page import="java.util.List"%>
<%@page import="gr.hackathon.zworld.model.Route"%>
<%@page import="gr.hackathon.zworld.util.ZworldUtils"%>
<%@page import="gr.hackathon.zworld.model.User"%>
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
%>
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
                    <!-- Main content -->
                    <section class="content">
                        <br>
                        <br>
                        <br>
                        <br>
                        <div class="row">
                            <!-- TABLE: ΝΕΕΣ ΔΙΑΔΡΟΜΕΣ -->
                            <div class="col-md-12">
                                <div class="box box-info">
                                    <div class="box-header with-border">
                                        <h3 class="box-title">Διαδρομές</h3>
                                    </div><!-- /.box-header -->
                                    <div class="box-body">
                                        <div class="table-responsive">
                                            <table class="table no-margin">
                                                <thead>
                                                    <tr>
                                                        <th>Διάδρομη</th>
                                                        <th>Σχόλια</th>
                                                        <th>Δημοτικότητα</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                    <%
                                                        List<Route> routeList = ZworldUtils.getAllRouteList();
                                                        for (int i = 0; i < routeList.size(); i++) {
                                                            List<RouteVotes> routeVoteList = routeList.get(i).getRouteVotesList();
                                                            int upvotes = 0;
                                                            int downvotes = 0;
                                                            int comments = 0;
                                                            for (int j = 0; j < routeVoteList.size(); j++) {
                                                                if (routeVoteList.get(j).getVoteStatus() == 1) {
                                                                    upvotes++;
                                                                } else if (routeVoteList.get(j).getVoteStatus() == -1) {
                                                                    downvotes++;
                                                                }
                                                            }
                                                            List<Comments> commentsList = ZworldUtils.getCommentsByRouteId(routeList.get(i).getRouteId());
                                                            for (Comments comment : commentsList) {
                                                                comments++;
                                                            }

                                                    %>
                                                    <tr>

                                                        <td><%=routeList.get(i).getStartRegionId().getName()%> - <%=routeList.get(i).getEndRegionId().getName()%></td>
                                                        <td><span class="label label-default"><%=comments%></span></td>
                                                        <td><span class="label label-success"><i class="icon fa fa-thumbs-up"></i> <%=upvotes%></span> <span class="label label-danger"><i class="icon fa  fa-thumbs-down"></i> <%=downvotes%></span></td>
                                                        <td><a href="./test-show-map.jsp?routeId=<%=routeList.get(i).getRouteId()%>">Προβολή</a></td>
                                                    </tr>
                                                    <%                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div><!-- /.table-responsive -->
                                    </div><!-- /.box-body -->
                                    <div class="box-footer clearfix">
                                        <a href="#" class="btn btn-sm btn-default btn-flat pull-right">Όλες οι νέες διαδρομές</a>
                                    </div><!-- /.box-footer -->
                                </div><!-- /.box -->
                            </div>
                        </div>
                        <br>
                        <br>
                        <div class="row">
                            <div class="col-md-6">
                                <a href="./polygons.jsp" class="btn btn-success btn-block btn-flat">Polygons</a>
                            </div>
                            
                            <div class="col-md-6">
                                <a href="./changeroute.jsp" class="btn btn-success btn-block btn-flat">Suggest change</a>

                            </div>
                        </div>

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
        <!-- Bootstrap 3.3.2 JS -->
        <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- FastClick -->
        <script src='plugins/fastclick/fastclick.min.js'></script>
        <!-- AdminLTE App -->
        <script src="dist/js/app.min.js" type="text/javascript"></script>
        <!-- Sparkline -->
        <script src="plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
        <!-- jvectormap -->
        <script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
        <script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
        <!-- SlimScroll 1.3.0 -->
        <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <!-- ChartJS 1.0.1 -->
        <script src="plugins/chartjs/Chart.min.js" type="text/javascript"></script>

        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="dist/js/pages/dashboard2.js" type="text/javascript"></script>

        <!-- AdminLTE for demo purposes -->
        <script src="dist/js/demo.js" type="text/javascript"></script>
    </body>
</html>
