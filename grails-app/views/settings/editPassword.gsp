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
    <title>Change Password</title>
</head>
<body>
<div class="body">
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${passwordForm}">
        <div class="errors">
            <g:renderErrors bean="${passwordForm}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="oldPassword"><g:message code="settings.oldPassword.label" default="Current Password"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: passwordForm, field: 'oldPassword', 'errors')}">
                        <g:passwordField name="oldPassword" value=""/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="newPassword"><g:message code="settings.newPassword.label" default="New Password"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: passwordForm, field: 'newPassword', 'errors')}">
                        <g:passwordField name="newPassword" value=""/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="newPasswordConfirm"><g:message code="settings.newPasswordConfirm.label" default="Confirm New Password"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: passwordForm, field: 'newPasswordConfirm', 'errors')}">
                        <g:passwordField name="newPasswordConfirm" value=""/>
                    </td>
                </tr>

                </tbody>
            </table>

            %{-- saved for resumeEdit of SettingsForm --}%
            <g:hiddenField name="loginEmail" value="${passwordForm.loginEmail}"/>
            <g:hiddenField name="dateFormat" value="${passwordForm.dateFormat}"/>
            <g:hiddenField name="timeZone" value="${passwordForm.timeZone}"/>
            <g:hiddenField name="settingsVersion" value="${passwordForm.settingsVersion}"/>
        </div>
        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="updatePassword" value="${message(code: 'default.button.update.label', default: 'Save')}"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
