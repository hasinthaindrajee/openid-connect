/*
 *  Copyright (c) WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.soasecurity.sample.webapp.oauth2;

import javax.servlet.ServletConfig;

/**
 * Config reader
 */
public class OAuth2Config {

    private static OAuth2Config oAuth2Config = null;

    private String consumerKey;
    private String consumerSecret;
    private String authorizeEndpoint;
    private String accessEndpoint;
    private String callBackUrl;
    private String userEndPoint;
    private String logoutUrl;


    private OAuth2Config(ServletConfig config) {

        this.consumerKey = config.getInitParameter(OAuth2Constants.CONSUMER_KEY);
        this.consumerSecret = config.getInitParameter(OAuth2Constants.CONSUMER_SECRET);
        this.callBackUrl = config.getInitParameter(OAuth2Constants.OAUTH2_CALL_BACK);
        String userInfoUrl = config.getInitParameter(OAuth2Constants.USER_INFO_URL);
        String serverUrl = config.getInitParameter(OAuth2Constants.OAUTH2_SERVER_URL);

        if(!serverUrl.endsWith("/")){
            serverUrl = serverUrl + "/";
        }

        this.authorizeEndpoint = serverUrl + "authorize";
        this.accessEndpoint = serverUrl + "token";

        if(userInfoUrl == null || userInfoUrl.trim().length() == 0) {
            this.userEndPoint = serverUrl + "userinfo?schema=openid";
        }
        buildLogoutUrl(serverUrl);
    }

    public static OAuth2Config getInstance(ServletConfig config){

        if(oAuth2Config == null) {
            oAuth2Config = new OAuth2Config(config);
        }

        return oAuth2Config;
    }

    public static OAuth2Config getInstance(){
        return oAuth2Config;
    }

    public String getConsumerKey() {
        return consumerKey;
    }

    public String getConsumerSecret() {
        return consumerSecret;
    }

    public String getAuthorizeEndpoint() {
        return authorizeEndpoint;
    }

    public String getAccessEndpoint() {
        return accessEndpoint;
    }

    public String getCallBackUrl() {
        return callBackUrl;
    }

    public String getUserEndPoint() {
        return userEndPoint;
    }

    public String getLogoutUrl() {
        return logoutUrl;
    }

    /**
     * creating logout url. sessionDataKey can be any random value.
     * @param serverUrl
     */
    private void buildLogoutUrl(String serverUrl){

        String commonAuthUrl = serverUrl.substring(0,serverUrl.indexOf("oauth2")) + "commonauth";

        this.logoutUrl = commonAuthUrl +"?commonAuthLogout=true&type=oauth2" +
                "&commonAuthCallerPath=" + callBackUrl;


    }
}
