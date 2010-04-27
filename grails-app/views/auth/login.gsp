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
<div class="body login">
    <auth:ifLoggedIn>
        You are currently logged in as: <auth:user/>
        <g:if test="${flash.authenticationFailure}">
            <div class="errors">
                <ul><li>Sorry but your logout failed - reason: <g:message code="authentication.failure.${flash.authenticationFailure.result}"/></li></ul>
            </div>
        </g:if>
        <h2>Log out</h2>
        <auth:form authAction="logout" success="[controller:'auth', action:'login']" error="[controller:'auth', action:'login']">
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
        <g:if test="${flash.authenticationFailure || hasErrors(bean: flash.loginFormErrors, true)}">
            %{-- get all the errors together into the same list for display --}%
            <g:if test="${flash.authenticationFailure}">
                %{ flash.loginFormErrors = flash.loginFormErrors ?: flash.loginForm.errors;
                   flash.loginFormErrors.reject(
                    "authentication.failure.${flash.authenticationFailure.result}",
                    "Login failed: " + message(code:"authentication.failure.${flash.authenticationFailure.result}")
                ) }%
            </g:if>
            <div class="errors">
                <g:renderErrors bean="${flash.loginFormErrors}" as="list"/>
            </div>
        </g:if>

        <h2>Please log in</h2>
        <auth:form authAction="login" success="[controller:'contact', action:'index']" error="[controller:'auth', action:'login']">
           <div class="dialog">
           <table>
               <tbody>
               <tr class="prop">
                   <td valign="top" class="name">
                        <label for="login">Email Address</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: flash.loginFormErrors, field: 'login', 'errors')}">
                        <g:textField id="login" name="login" size="42" value="${flash.loginForm?.login?.encodeAsHTML()}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="password">Password</label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: flash.loginFormErrors, field: 'login', 'errors')}">
                        <input id="password" name="password" value="" type="password"/>
                    </td>
                </tr>
                </tbody>
            </table>
            </div>
            <div class="buttons">
                <g:actionSubmit value="Log in" class="save"/>
            </div>
        </auth:form>

        <div>
            <g:link action="forgot">Forgot password</g:link>
        </div>
        <div>
            <g:link action="signup">Sign up for new account</g:link>
        </div>
    </auth:ifNotLoggedIn>
</div>
</body>
</html>