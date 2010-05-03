%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<%@ page import="com.getsu.wcy.Person" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'contact.label', default: 'Contact')}"/>
  <title><g:message code="default.list.label" args="[entityName]" /></title>
    <g:javascript library="scriptaculous"/>
    <g:javascript src="expandManager.js"/>
    <script type="text/javascript">
        $(document).observe('dom:loaded', function() {ExpandManager.init()});
    </script>
</head>
<body>
<div class="nav">
    <g:form name="searchForm">
        <g:textField name="search" size="42" value="${search}"/>
        <span class="menuButton"><g:actionSubmit value="Search"/></span>
    </g:form>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
</div>
<div class="body">
  <g:render template="/person/list"/>
</div>
</body>
</html>
