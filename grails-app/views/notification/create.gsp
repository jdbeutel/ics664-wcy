
<%@ page import="com.getsu.wcy.Notification" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'notification.label', default: 'Notification')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${notificationInstance}">
            <div class="errors">
                <g:renderErrors bean="${notificationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="verb"><g:message code="notification.verb.label" default="Verb" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: notificationInstance, field: 'verb', 'errors')}">
                                    <g:textField name="verb" value="${notificationInstance?.verb}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subject"><g:message code="notification.subject.label" default="Subject" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: notificationInstance, field: 'subject', 'errors')}">
                                    <g:select name="subject.id" from="${com.getsu.wcy.User.list()}" optionKey="id" value="${notificationInstance?.subject?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="object"><g:message code="notification.object.label" default="Object" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: notificationInstance, field: 'object', 'errors')}">
                                    <g:select name="object.id" from="${com.getsu.wcy.Person.list()}" optionKey="id" value="${notificationInstance?.object?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="date"><g:message code="notification.date.label" default="Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: notificationInstance, field: 'date', 'errors')}">
                                    <g:datePicker name="date" precision="day" value="${notificationInstance?.date}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="recipient"><g:message code="notification.recipient.label" default="Recipient" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: notificationInstance, field: 'recipient', 'errors')}">
                                    <g:select name="recipient.id" from="${com.getsu.wcy.User.list()}" optionKey="id" value="${notificationInstance?.recipient?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
