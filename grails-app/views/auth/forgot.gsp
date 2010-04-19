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
    <title>Forgot Password</title>
</head>
<body>
<div class="body">
    <auth:ifLoggedIn>
        You are currently logged in as: <auth:user/>
    </auth:ifLoggedIn>
    <auth:ifNotLoggedIn>
        todo: request mail; lookup name?
    </auth:ifNotLoggedIn>
</div>
</body>
</html>