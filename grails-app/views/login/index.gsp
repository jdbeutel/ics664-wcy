%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="unauth"/>
    <title>Login</title>
</head>
<body>
<div class="body">
    <auth:ifLoggedIn>
        You are currently logged in as: <auth:user/>
        <g:if test="${flash.authenticationFailure}">
            <div class="errors">
                <ul><li>Sorry but your logout failed - reason: <g:message code="authentication.failure.${flash.authenticationFailure.result}"/></li></ul>
            </div>
        </g:if>
        <h2>Log out</h2>
        <auth:form authAction="logout" success="[controller:'login', action:'index']" error="[controller:'login', action:'index']">
            <div class="buttons">
                <g:actionSubmit value="Log out"/>
            </div>
        </auth:form>
    </auth:ifLoggedIn>
%{--
<auth:ifUnconfirmed>
    You've registered but we're still waiting to confirm your account. <g:link action="reconfirm">Click here to send a new confirmation request</g:link> if you missed it the first time.
</auth:ifUnconfirmed>
--}%
    <auth:ifNotLoggedIn>
        <g:if test="${flash.authenticationFailure}">
            <div class="errors">
                <ul><li>Login failed: <g:message code="authentication.failure.${flash.authenticationFailure.result}"/></li></ul>
            </div>
        </g:if>

        <h2>Please log in</h2>
        <auth:form authAction="login" success="[controller:'notification', action:'index']" error="[controller:'login', action:'index']">
            <label for="login">Email:</label> <g:textField id="login" name="login" size="42" value="${flash.loginForm?.login?.encodeAsHTML()}"/><br/>
            <g:hasErrors bean="${flash.loginFormErrors}" field="login">
                <div class="errors">
                    <g:renderErrors bean="${flash.loginFormErrors}" as="list" field="login"/>
                </div>
            </g:hasErrors>
            <label for="password">Password:</label> <input id="password" name="password" value="" type="password"/><br/>
            <g:hasErrors bean="${flash.loginFormErrors}" field="password">
                <div class="errors">
                    <g:renderErrors bean="${flash.loginFormErrors}" as="list" field="password"/>
                </div>
            </g:hasErrors>
            <div class="buttons">
                <g:actionSubmit value="Log in" class="save"/>
            </div>
        </auth:form>

        <g:link action="forgot">Forgot password</g:link><br/>
        <g:link controller="signup" action="index">Sign up for new account</g:link>
    </auth:ifNotLoggedIn>
</div>
</body>
</html>