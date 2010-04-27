
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
        <title>My Profile</title>
        <g:javascript library="scriptaculous"/>
        <g:javascript src="changeManager.js"/>
        <script type="text/javascript">
            $(document).observe('dom:loaded', function() {ChangeManager.init($('htmlForm'), $$('input.save')[0], [])});
        </script>
    </head>
    <body>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${personInstance}">
            <div class="errors">
                <g:renderErrors bean="${personInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:uploadForm name="htmlForm" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <g:render template="/person/editCore"/>
                            <tr>
                                <td colspan="2">
                                    <wcy:requiredLegend/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="updateMyProfile" value="${message(code: 'default.button.update.label', default: 'Save')}" /></span>
                </div>
            </g:uploadForm>
        </div>
    </body>
</html>
