%{--
- Copyright (c) 2010 J. David Beutel <software@getsu.com>
-
- Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
--}%
<%@ page import="com.getsu.wcy.Person" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>
<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></span>
</div>
<div class="body">
    <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${personInstance}">
        <div class="errors">
            <g:renderErrors bean="${personInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form method="post">
        <g:hiddenField name="id" value="${personInstance?.id}"/>
        <g:hiddenField name="version" value="${personInstance?.version}"/>
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="preferredName"><g:message code="person.preferredName.label" default="Preferred Name"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'preferredName', 'errors')}">
                        <g:textField name="preferredName" value="${personInstance?.preferredName}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="honorific"><g:message code="person.honorific.label" default="Honorific"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'honorific', 'errors')}">
                        <g:textField name="honorific" value="${personInstance?.honorific}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="givenNames"><g:message code="person.givenNames.label" default="Given Names"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'givenNames', 'errors')}">
                        <g:textField name="givenNames" value="${personInstance?.givenNames}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="familyName"><g:message code="person.familyName.label" default="Family Name"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'familyName', 'errors')}">
                        <g:textField name="familyName" value="${personInstance?.familyName}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="suffix"><g:message code="person.suffix.label" default="Suffix"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'suffix', 'errors')}">
                        <g:textField name="suffix" value="${personInstance?.suffix}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="photo"><g:message code="person.photo.label" default="Photo"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'photo', 'errors')}">

                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="birthDate"><g:message code="person.birthDate.label" default="Birth Date"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'birthDate', 'errors')}">
                        <g:datePicker name="birthDate" precision="day" value="${personInstance?.birthDate}" noSelection="['': '']"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="places"><g:message code="person.places.label" default="Places"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'places', 'errors')}">
                        <g:select name="places" from="${com.getsu.wcy.Connection.list()}" multiple="yes" optionKey="id" size="5" value="${personInstance?.places}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="comLinks"><g:message code="person.phoneNumbers.label" default="Phone Numbers"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'phoneNumbers', 'errors')}">
                        <g:select name="comLinks" from="${com.getsu.wcy.PhoneNumber.list()}" multiple="yes" optionKey="id" size="5" value="${personInstance?.comLinks}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
        <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
