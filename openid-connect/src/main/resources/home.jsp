<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>LOGIN WITH OPENID CONNECT</title>
    <link rel="stylesheet" href="css/style.css">
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>

<%
    String userName = (String) session.getAttribute("username");
    if (userName == null) {
        response.sendRedirect("index.jsp?error=User not logged in. Please login again.");
    }

%>

<body>

<form method="post" action="logout.jsp">
    <p align="right" style="color: #fff"> Logged in as <%=userName%></p>

    <p align="right" class="submit"><input type="submit" name="commit" value="Log Out"></p>
</form>


<section class="container">
    <div class="login">
        <h1>Welcome...!!!</h1>
        <form action="user-info.jsp" id="loginForm" method="post">
            <table style="width:100%;text-align:center;'">
                <tr>
                    <td style="text-align:center;width:100%">
                        <input type="submit" class="button" value="Retrieve User Profile"/>
                    </td>
                </tr>
            </table>
        </form>
        <div>

        <div class="login-help">
            <p><a>http://soasecurity.org</a></p>
        </div>
</section>

</body>

</html>
