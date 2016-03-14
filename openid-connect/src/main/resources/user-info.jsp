<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.soasecurity.sample.webapp.oauth2.OAuth2Constants" %>
<%@ page import="org.soasecurity.sample.webapp.oauth2.OAuth2Config" %>
<%@ page import="org.json.simple.parser.ParseException" %>

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
    <<title>LOGIN WITH OPENID CONNECT</title>
    <link rel="stylesheet" href="css/style.css">
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>

<%

    String userName = (String) session.getAttribute("username");
    if (userName == null) {
        response.sendRedirect("index.jsp?error=User not logged in. Please login again.");
    }

    String accessToken  = (String) session.getAttribute(OAuth2Constants.ACCESS_TOKEN);

    String result = executeGet(OAuth2Config.getInstance().getUserEndPoint(), "", accessToken);

    System.out.println("Received User Info JSON :" + result);

    JSONObject userInfo = null;

    if(result != null) {
        JSONParser parser = new JSONParser();
        try {
            userInfo = (JSONObject)parser.parse(result);
        } catch (ParseException e) {
            e.printStackTrace();
        }
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
        <form method="post" action="home.jsp">
            <table style="width:100%;text-align:center;'">
                <%
                    if(userInfo != null){

                        Iterator<?> ite = userInfo.entrySet().iterator();

                        while(ite.hasNext()) {
                            Map.Entry entry = (Map.Entry)ite.next();
                %>
                <tr>
                    <td style="width:50%" style="color: #fff"><%=entry.getKey()%> </td>
                    <td><%=entry.getValue()%></td>
                </tr>

                <%
                        }
                    } else {
                %>
                    <tr>
                        <td>Sorry. No User information is retrieved </td>
                    </tr>
                <%
                    }
                %>

                <tr>
                    <td style="text-align:center;width:100%">

                    </td>
                </tr>
                <table style="width:100%;text-align:center;'">
                    <tr>
                        <td style="text-align:center;width:100%">
                            <input type="submit" class="button" value="Back" />
                        </td>
                    </tr>
                </table>
            </table>
            </form>
        <div>
        <div class="login-help">
            <p><a>http://soasecurity.org</a></p>
        </div>
</section>

</body>
</html>


<%!
    public static String executeGet(String targetURL, String urlParameters, String accessTokenIdentifier){
        try {
            URL myURL = new URL(targetURL);
            URLConnection myURLConnection = myURL.openConnection();
            myURLConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            myURLConnection.setRequestProperty("Authorization","Bearer " + accessTokenIdentifier);
            myURLConnection.setRequestProperty("Content-Language", "en-US");
            myURLConnection.setUseCaches (false);
            myURLConnection.setDoInput(true);
            myURLConnection.setDoOutput(true);

            BufferedReader br = new BufferedReader(new InputStreamReader(myURLConnection.getInputStream()));
            String line;
            StringBuilder response = new StringBuilder();

            while((line = br.readLine()) != null) {
                response.append(line);
                response.append('\r');
            }
            br.close();
            return response.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
%>
