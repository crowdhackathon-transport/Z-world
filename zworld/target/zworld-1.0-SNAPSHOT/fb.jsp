<%-- 
    Document   : fb
    Created on : 1 Ιουλ 2015, 12:29:10 μμ
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="fb-root"></div>
        <script>(function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id))
                    return;
                js = d.createElement(s);
                js.id = id;
                js.src = "//connect.facebook.net/el_GR/sdk.js#xfbml=1&version=v2.3&appId=722497001207044";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));</script>
        <h1>Hello World!</h1>

        <div class="fb-comments" data-href="http://localhost:8080/antegeia" data-numposts="5"></div>
    </body>
</html>
