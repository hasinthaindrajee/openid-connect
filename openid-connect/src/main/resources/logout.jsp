
<%@ page import="org.soasecurity.sample.webapp.oauth2.OAuth2Config" %>


<%
  session.setAttribute("username", null);
  session.invalidate();
  response.sendRedirect(OAuth2Config.getInstance().getLogoutUrl());
%>

