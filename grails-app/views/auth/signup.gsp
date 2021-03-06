%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="unauth"/>
    <title>Sign up</title>
    <g:javascript library="scriptaculous"/>
    <g:javascript src="changeManager.js"/>
    <script type="text/javascript">
        $(document).observe('dom:loaded', function() {ChangeManager.init($('htmlForm'), $('doSignup'), [])});
    </script>
</head>
<body>
<div class="body">
    <auth:ifLoggedIn>
        You are currently logged in as: <auth:user/>
        <g:if test="${flash.authenticationFailure}">
            <div class="errors">
                <ul><li>Sorry but your logout failed - reason: <g:message code="authentication.failure.${flash.authenticationFailure.result}"/></li></ul>
            </div>
        </g:if>
        <h2>Log out</h2>
        <auth:form authAction="logout" success="[controller:'login', action:'signup']" error="[controller:'login', action:'signup']">
            <div class="buttons">
                <g:actionSubmit value="Log out"/>
            </div>
        </auth:form>
    </auth:ifLoggedIn>

    <auth:ifNotLoggedIn>
        <div class="body">
            <h2>Please sign up</h2>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${personInstance}">
                <div class="errors">
                    <g:renderErrors bean="${personInstance}" as="list" />
                </div>
            </g:hasErrors>
            <g:hasErrors bean="${signupForm}">
                <div class="errors">
                    <g:renderErrors bean="${signupForm}" as="list" />
                </div>
            </g:hasErrors>
            <g:uploadForm name="htmlForm" action="doSignup" method="post" >
                <div class="dialog">

                    <table>
                        <tbody>
                        <tr class="prop">
                            <td valign="top" class="required name">
                                <label for="login">Email</label>
                            </td>
                            <td valign="top" class="required value ${hasErrors(bean: signupForm, field: 'login', 'errors')}">
                                <g:textField name="login" size="42" value="${signupForm?.login}" /> <wcy:required/>
                            </td>
                        </tr>

                        <g:hiddenField name="email" value="ignored@example.com"/>

                        <tr class="prop">
                            <td valign="top" class="required name">
                                <label for="password">Password</label>
                            </td>
                            <td valign="top" class="required value ${hasErrors(bean: signupForm, field: 'password', 'errors')}">
                                <g:passwordField name="password" value="" /> <wcy:required/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="required name">
                                <label for="passwordConfirm">Confirm password</label>
                            </td>
                            <td valign="top" class="required value ${hasErrors(bean: signupForm, field: 'passwordConfirm', 'errors')}">
                                <g:passwordField name="passwordConfirm" value="" /> <wcy:required/>
                            </td>
                        </tr>

                        <g:render template="/person/editCore"/>

                        <tr class="prop">
                            <td valign="top" class="required name">
                                <label for="connections[0].place.addresses[0].city">Home City</label>
                            </td>
                            <td valign="top" class="required value ${hasErrors(bean: personInstance, field: 'connections[0].place.addresses[0].city', 'errors')}">
                                <g:hiddenField name="connections[0].type" value="HOME" /> %{-- constraint --}%
                                <g:hiddenField name="connections[0].place.addresses[0].streetType" value="true" /> %{-- force bind to create, for easier validation --}%
                                <g:textField name="connections[0].place.addresses[0].city"
                                        value="${personInstance?.connections?.first()?.place?.addresses?.first()?.city}" /> <wcy:required/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="required name">
                                <label for="connections[0].place.addresses[0].state">Home State</label>
                            </td>
                            <td valign="top" class="required value ${hasErrors(bean: personInstance, field: 'connections[0].place.addresses[0].state', 'errors')}">
                                <g:textField name="connections[0].place.addresses[0].state"
                                        value="${personInstance?.connections?.first()?.place?.addresses?.first()?.state}" /> <wcy:required/>
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
                    <span class="button"><g:submitButton name="doSignup" class="save" value="Sign up" /></span>
                </div>
            </g:uploadForm>
        </div>
    </auth:ifNotLoggedIn>
</div>
</body>
</html>