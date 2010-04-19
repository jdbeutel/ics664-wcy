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
    <title>Logged out</title>
</head>
<body>
<div class="body">
    <auth:ifLoggedIn>
        <div class="errors">
            <ul><li>Sorry but your logout failed - reason: <g:message code="authentication.failure.${flash.authenticationFailure.result}"/></li></ul>
        </div>
    </auth:ifLoggedIn>
    <auth:ifNotLoggedIn>
        <div class="message">Logout succeeded</div>

        <g:link action="login">Log back in again</g:link><br/>
    </auth:ifNotLoggedIn>
</div>
</body>
</html>
