<%@page import="org.soasecurity.sample.webapp.oauth2.OAuth2Constants"%>
<%@page import="org.apache.amber.oauth2.client.URLConnectionClient"%>
<%@page import="org.apache.amber.oauth2.client.response.OAuthClientResponse"%>
<%@page import="org.apache.amber.oauth2.client.OAuthClient"%>
<%@page import="org.apache.amber.oauth2.common.message.types.GrantType"%>
<%@page import="org.apache.amber.oauth2.client.request.OAuthClientRequest" %>
<%@page import="org.apache.amber.oauth2.client.response.OAuthAuthzResponse"%>
<%@page import="org.soasecurity.sample.webapp.oauth2.OAuth2Config" %>
<%@ page import="org.apache.oltu.oauth2.jwt.JWTProcessor" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%
    try {

        String type = request.getParameter("type");

        String consumerKey = OAuth2Config.getInstance().getConsumerKey();
        String consumerSecret = OAuth2Config.getInstance().getConsumerSecret();
        String authzEndpoint = OAuth2Config.getInstance().getAuthorizeEndpoint();
        String tokenEndpoint = OAuth2Config.getInstance().getAccessEndpoint();
        String callBackUrl = OAuth2Config.getInstance().getCallBackUrl();

        if("openidConnect".equals(type)) {

            String authzGrantType = OAuth2Constants.OAUTH2_GRANT_TYPE_CODE;
            String scope = OAuth2Constants.OPENID_CONNECT_SCOPE;

            OAuthClientRequest authzRequest = OAuthClientRequest
                    .authorizationLocation(authzEndpoint)
                    .setClientId(consumerKey)
                    .setRedirectURI(callBackUrl)
                    .setResponseType(authzGrantType)
                    .setScope(scope)
                    .buildQueryMessage();
            response.sendRedirect(authzRequest.getLocationUri());
            return;

        } else {

            OAuthAuthzResponse authzResponse = OAuthAuthzResponse.oauthCodeAuthzResponse(request);
            String code = authzResponse.getCode();

            System.out.println("Authorizaton Code : " + code);

            if(code != null && code.trim().length() > 0) {
                OAuthClientRequest accessRequest = OAuthClientRequest.tokenLocation(tokenEndpoint)
                        .setGrantType(GrantType.AUTHORIZATION_CODE)
                        .setClientId(consumerKey)
                        .setClientSecret(consumerSecret)
                        .setRedirectURI(callBackUrl)
                        .setCode(code)
                        .buildBodyMessage();

                //create OAuth client that uses custom http client under the hood
                OAuthClient oAuthClient = new OAuthClient(new URLConnectionClient());
                OAuthClientResponse oAuthResponse = oAuthClient.accessToken(accessRequest);

                // retrieve access token
                String accessToken = oAuthResponse.getParam(OAuth2Constants.ACCESS_TOKEN);
                session.setAttribute(OAuth2Constants.ACCESS_TOKEN, accessToken);

                // retrieve id token
                String idToken = oAuthResponse.getParam(OAuth2Constants.ID_TOKEN);

                System.out.println("Access Token : " + accessToken);
                System.out.println("ID Token : " + idToken);

                if (idToken != null) {
                    session.setAttribute(OAuth2Constants.ID_TOKEN, idToken);
                    // process id_token
                    //***************   Important to verify the signature of id_token ************* TODO//
                    JWTProcessor jwtProcessor = new JWTProcessor();
                    jwtProcessor.process(idToken);
                    // retrieve username using sub attribute
                    String userName = (String)jwtProcessor.getPayloadClaimValue("sub");
                    // remove tenant domain from username
                    userName = userName.split("@")[0];
                    session.setAttribute("username", userName);
                    RequestDispatcher view = request.getRequestDispatcher("home.jsp");
                    view.forward(request, response);
                }
            } else {
%>
<script type="text/javascript">
    window.location = "index.jsp?error=Authentication Failure";
</script>
<%
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
<script type="text/javascript">
    window.location = "index.jsp?error=Authentication Failure";
</script>

<%
    }
%>



    