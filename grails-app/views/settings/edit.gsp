%{--
- Copyright (c) 2010 J. David Beutel <software@getsu.com>
-
- Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
--}%
<%@ page import="com.getsu.wcy.Settings" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'settings.label', default: 'Settings')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>
<body>
<div class="body">
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${settingsForm}">
        <div class="errors">
            <g:renderErrors bean="${settingsForm}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <g:hiddenField name="userVersion" value="${settingsForm?.userVersion}"/>
        <g:hiddenField name="settingsVersion" value="${settingsForm?.settingsVersion}"/>
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="loginEmail"><g:message code="settings.loginEmail.label" default="Login Email"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: settingsForm, field: 'loginEmail', 'errors')}">
                        <g:textField name="loginEmail" size="42" value="${settingsForm?.loginEmail}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="timeZone"><g:message code="settings.timeZone.label" default="Time Zone"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: settingsForm, field: 'timeZone', 'errors')}">
                        <wcy:timeZoneSelect name="timeZone" value="${settingsForm?.timeZone}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="dateFormat"><g:message code="settings.dateFormat.label" default="Date Format"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: settingsForm, field: 'dateFormat', 'errors')}">
                        <wcy:dateFormatSelect name="dateFormat" value="${settingsForm?.dateFormat}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Save')}"/></span>
            <span class="button"><g:actionSubmit class="edit" action="editPassword" value="Change Password"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
