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
    <g:javascript src="changeManager.js"/>
    <script type="text/javascript">
        $(document).observe('dom:loaded', function() {ExpandManager.init()});
        $(document).observe('dom:loaded', function() {ChangeManager.init($('htmlForm'), $$('input.save')[0], [])});
    </script>
    <script type="text/javascript">
        var ExpandManager = {
            init: function() {
                $('changePasswordToggle').show();
                $('changePasswordWithoutJsSpan').hide();
                if (!$F($('htmlForm')['changePassword'])) {
                    %{-- trying to stop Firefox from filling in oldPassword later, but nothing is working --}%
                    %{--var opw = $('htmlForm')['oldPassword'];--}%
                    %{--$(opw).focus().clear();--}%
                    %{--$($('htmlForm')['timeZone']).focus(); --}%%{-- harmless if accidentally changed --}%
                    $('changePasswordDiv').hide();
                }
                ExpandManager.updateChangePasswordToggle();
            },
            toggleChangePassword: function() {
                var showNow = !$F($('htmlForm')['changePassword']);
                $($('htmlForm')['changePassword']).setValue(showNow);
                if (showNow) {
                    Effect.SlideDown('changePasswordDiv', {duration:0.5});
                } else {
                    Effect.SlideUp('changePasswordDiv', {duration:0.5});
                }
                ExpandManager.updateChangePasswordToggle();
            },
            updateChangePasswordToggle: function() {
                if ($F($('htmlForm')['changePassword'])) {
                    $('changePasswordToggle').update('V Cancel password change').removeClassName('closed').addClassName('open');
                } else {
                    $('changePasswordToggle').update('&gt; Change Password').removeClassName('open').addClassName('closed');
                }
            }
        }
    </script>
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
    <g:form name="htmlForm" method="post"> %{-- grails name -> id --}%
        <g:hiddenField name="userVersion" value="${settingsForm?.userVersion}"/>
        <g:hiddenField name="settingsVersion" value="${settingsForm?.settingsVersion}"/>
        <g:hiddenField name="originalValuesJSON" value="${settingsForm?.originalValuesJSON}"/>
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="required name">
                        <label for="loginEmail"><g:message code="settings.loginEmail.label" default="Email Address (for log in)"/></label>
                    </td>
                    <td valign="top" class="required value ${hasErrors(bean: settingsForm, field: 'loginEmail', 'errors')}">
                        <g:textField name="loginEmail" size="42" value="${settingsForm?.loginEmail}"/> <wcy:required/>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <a href="#" id="changePasswordToggle" class="expander" onclick="ExpandManager.toggleChangePassword()" style="display: none">&gt; Change Password</a>
                        <span id="changePasswordWithoutJsSpan">
                            <label for="changePassword">Change Password</label>
                            <g:checkBox name="changePassword" value="${settingsForm?.changePassword}"/>
                        </span>
                        <div id="changePasswordDiv">
                            <div class="dialog"> %{-- nesting required for Scriptaculous slide effect --}%
                                <table>
                                    <tbody>

                                    <tr class="prop">
                                        <td valign="top" class="required name">
                                            <label for="oldPassword"><g:message code="settings.oldPassword.label" default="Current Password"/></label>
                                        </td>
                                        <td valign="top" class="required value ${hasErrors(bean: settingsForm, field: 'oldPassword', 'errors')}">
                                            <g:passwordField name="oldPassword" value="${settingsForm?.oldPassword}" autocomplete="off"/> <wcy:required/>
                                        </td>
                                    </tr>

                                    <tr class="prop">
                                        <td valign="top" class="required name">
                                            <label for="newPassword"><g:message code="settings.newPassword.label" default="New Password"/></label>
                                        </td>
                                        <td valign="top" class="required value ${hasErrors(bean: settingsForm, field: 'newPassword', 'errors')}">
                                            <g:passwordField name="newPassword" value="${settingsForm?.newPassword}" autocomplete="off"/> <wcy:required/>
                                        </td>
                                    </tr>

                                    <tr class="prop">
                                        <td valign="top" class="required name">
                                            <label for="newPasswordConfirm"><g:message code="settings.newPasswordConfirm.label" default="Confirm New Password"/></label>
                                        </td>
                                        <td valign="top" class="required value ${hasErrors(bean: settingsForm, field: 'newPasswordConfirm', 'errors')}">
                                            <g:passwordField name="newPasswordConfirm" value="${settingsForm?.newPasswordConfirm}" autocomplete="off"/> <wcy:required/>
                                        </td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="required name">
                        <label for="timeZone"><g:message code="settings.timeZone.label" default="Time Zone"/></label>
                    </td>
                    <td valign="top" class="required value ${hasErrors(bean: settingsForm, field: 'timeZone', 'errors')}">
                        <wcy:timeZoneSelect name="timeZone" value="${settingsForm?.timeZone}"/> <wcy:required/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="required name">
                        <label for="dateFormat"><g:message code="settings.dateFormat.label" default="Date Format"/></label>
                    </td>
                    <td valign="top" class="required value ${hasErrors(bean: settingsForm, field: 'dateFormat', 'errors')}">
                        <wcy:dateFormatSelect name="dateFormat" value="${settingsForm?.dateFormat}"/> <wcy:required/>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <wcy:requiredLegend/>
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
