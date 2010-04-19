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
    <title>Sign up</title>
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
        <auth:form authAction="logout" success="[controller:'login', action:'signup']" error="[controller:'login', action:'signup']">
            <div class="buttons">
                <g:actionSubmit value="Log out"/>
            </div>
        </auth:form>
    </auth:ifLoggedIn>
    <auth:ifNotLoggedIn>
        <g:if test="${flash.authenticationFailure}">
            <div class="errors">
                <ul><li>Sign up failed: <g:message code="authentication.failure.${flash.authenticationFailure.result}"/></li></ul>
            </div>
        </g:if>

        <h2>Please sign up</h2>
        <auth:form authAction="signup"
                success="[controller:'contact', action:'index']"
                error="[controller:'login', action:'signup']">
            <label for="login">Email:</label> <g:textField name="login" size="42" value="${flash.signupForm?.login?.encodeAsHTML()}"/><br/>
            <g:hasErrors bean="${flash.signupFormErrors}" field="login">
                <div class="errors">
                    <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="login"/>
                </div>
            </g:hasErrors>
            <g:hiddenField name="email" value="ignored@example.com"/>
            <g:hasErrors bean="${flash.signupFormErrors}" field="email">
                <div class="errors">
                    <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="email"/>
                </div>
            </g:hasErrors>
            <label for="password">Password:</label> <input id="password" name="password" value="" type="password"/><br/>
            <g:hasErrors bean="${flash.signupFormErrors}" field="password">
                <div class="errors">
                    <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="password"/>
                </div>
            </g:hasErrors>
            <label for="passwordConfirm">Confirm password:</label> <input id="passwordConfirm" name="passwordConfirm" value="" type="password"/><br/>
            <g:hasErrors bean="${flash.signupFormErrors}" field="passwordConfirm">
                <div class="errors">
                    <g:renderErrors bean="${flash.signupFormErrors}" as="list" field="passwordConfirm"/>
                </div>
            </g:hasErrors>
            <div class="buttons">
                <g:actionSubmit value="Sign up" class="save"/>
            </div>
        </auth:form>
    </auth:ifNotLoggedIn>
</div>
</body>
</html>