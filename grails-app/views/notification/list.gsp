
<%@ page import="com.getsu.wcy.Notification" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'notification.label', default: 'Notification')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    <!--
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
    -->
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        

                            <th><g:message code="notification.subject.label" default="Who" /></th>

                          <g:sortableColumn property="verb" title="${message(code: 'notification.verb.label', default: 'What')}" />

                            <th><g:message code="notification.object.label" default="To Whom" /></th>
                   	    
                            <g:sortableColumn property="date" title="${message(code: 'notification.date.label', default: 'When')}" />

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${notificationInstanceList}" status="i" var="notificationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>
                              ${fieldValue(bean: notificationInstance, field: "subject.person.firstGivenName")}
                              ${fieldValue(bean: notificationInstance, field: "subject.person.familyName")}
                            </td>

                          <td>${fieldValue(bean: notificationInstance, field: "verb")}</td>

                            <td>
                              ${fieldValue(bean: notificationInstance, field: "object.firstGivenName")}
                              ${fieldValue(bean: notificationInstance, field: "object.familyName")}
                            </td>
                        
                            <td><g:formatDate date="${notificationInstance.date}" /></td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${notificationInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
