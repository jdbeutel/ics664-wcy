
%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<%@ page import="com.getsu.wcy.Settings" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'settings.label', default: 'Settings')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'settings.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="timeZone" title="${message(code: 'settings.timeZone.label', default: 'Time Zone')}" />
                        
                            <g:sortableColumn property="dateFormat" title="${message(code: 'settings.dateFormat.label', default: 'Date Format')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${settingsInstanceList}" status="i" var="settingsInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${settingsInstance.id}">${fieldValue(bean: settingsInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: settingsInstance, field: "timeZone")}</td>
                        
                            <td>${fieldValue(bean: settingsInstance, field: "dateFormat")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${settingsInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
