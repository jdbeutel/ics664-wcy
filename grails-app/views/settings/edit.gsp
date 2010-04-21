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
    <g:javascript library="scriptaculous"/>
    <g:set var="entityName" value="${message(code: 'settings.label', default: 'Settings')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
    <script type="text/javascript">
        function doOnLoad() {
            $('changePasswordToggle').show();
            $('changePasswordWithoutJsSpan').hide();
            if (!$F($('htmlForm')['changePassword'])) {
                %{-- trying to stop Firefox from filling in oldPassword later, but nothing is working --}%
                %{--var opw = $('htmlForm')['oldPassword'];--}%
                %{--$(opw).focus().clear();--}%
                %{--$($('htmlForm')['timeZone']).focus(); --}%%{-- harmless if accidentally changed --}%
                $('changePasswordDiv').hide();
            }
            updateChangePasswordToggle();
        }
        function toggleChangePassword() {
            var showNow = !$F($('htmlForm')['changePassword']);
            $($('htmlForm')['changePassword']).setValue(showNow);
            if (showNow) {
                Effect.SlideDown('changePasswordDiv');
            } else {
                Effect.SlideUp('changePasswordDiv');
            }
            updateChangePasswordToggle();
        }
        function updateChangePasswordToggle() {
            if ($F($('htmlForm')['changePassword'])) {
                $('changePasswordToggle').update('V Cancel password change').removeClassName('closed').addClassName('open');
            } else {
                $('changePasswordToggle').update('&gt; Change Password').removeClassName('open').addClassName('closed');
            }
        }
    </script>
</head>
<body onload="doOnLoad()">
<div class="body">
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${settingsForm}">
        <div class="errors">
            <g:renderErrors bean="${settingsForm}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form name="htmlForm" method="post"> %{-- grails name -> id --}%
        <g:hiddenField name="userVersion" value="${settingsForm?.userVersion}"/>
        <g:hiddenField name="settingsVersion" value="${settingsForm?.settingsVersion}"/>
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="loginEmail"><g:message code="settings.loginEmail.label" default="Email Address (for log in)"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: settingsForm, field: 'loginEmail', 'errors')}">
                        <g:textField name="loginEmail" size="42" value="${settingsForm?.loginEmail}"/>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <a href="#" id="changePasswordToggle" class="expander" onclick="toggleChangePassword()" style="display: none">&gt; Change Password</a>
                        <span id="changePasswordWithoutJsSpan">
                            <label for="changePassword">Change Password</label>
                            <g:checkBox name="changePassword" value="${settingsForm?.changePassword}"/>
                        </span>
                        <div id="changePasswordDiv">
                            <div class="dialog"> %{-- nesting required for Scriptaculous slide effect --}%
                                <table>
                                    <tbody>

                                    <tr class="prop">
                                        <td valign="top" class="name">
                                            <label for="oldPassword"><g:message code="settings.oldPassword.label" default="Current Password"/></label>
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: settingsForm, field: 'oldPassword', 'errors')}">
                                            <g:passwordField name="oldPassword" value="${settingsForm?.oldPassword}" autocomplete="off"/>
                                        </td>
                                    </tr>

                                    <tr class="prop">
                                        <td valign="top" class="name">
                                            <label for="newPassword"><g:message code="settings.newPassword.label" default="New Password"/></label>
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: settingsForm, field: 'newPassword', 'errors')}">
                                            <g:passwordField name="newPassword" value="${settingsForm?.newPassword}" autocomplete="off"/>
                                        </td>
                                    </tr>

                                    <tr class="prop">
                                        <td valign="top" class="name">
                                            <label for="newPasswordConfirm"><g:message code="settings.newPasswordConfirm.label" default="Confirm New Password"/></label>
                                        </td>
                                        <td valign="top" class="value ${hasErrors(bean: settingsForm, field: 'newPasswordConfirm', 'errors')}">
                                            <g:passwordField name="newPasswordConfirm" value="${settingsForm?.newPasswordConfirm}" autocomplete="off"/>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>
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
        </div>
    </g:form>
</div>
</body>
</html>
