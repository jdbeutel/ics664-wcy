%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Directory</title>
  <g:javascript library="scriptaculous"/>
  <g:javascript src="expandManager.js"/>
  <script type="text/javascript">
    $(document).observe('dom:loaded', function() {ExpandManager.init()});
  </script>
</head>
<body>
<div class="nav">
  <g:form>
    <g:textField name="search" size="42" value="${search}"/>
    <span class="menuButton"><g:actionSubmit value="Search"/></span>
  </g:form>
</div>
<div class="body">
    <g:render template="/person/list"/>
</div>
</body>
</html>
