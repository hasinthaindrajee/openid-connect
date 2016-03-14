<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>LOGIN WITH OPENID CONNECT</title>
	<link rel="stylesheet" href="css/style.css">
	<!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>
<%
	request.getSession().removeAttribute("username");
%>

<body>

<section class="container">
	<div class="login">
		<h1>OpenId Connect Web Application</h1>
		<form action="oauth2.jsp" id="loginForm" method="post">
			<table style="width:100%;text-align:center;'">
				<tr>
					<td><input type="hidden" value="openidConnect" name="type"/></td>
				</tr>
				<tr>
					<td style="text-align:center;width:100%">
						<input type="submit" class="button" value="Login With OpenID-Connect"/>
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
