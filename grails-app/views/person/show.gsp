<%@ page import="com.getsu.wcy.Person" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>
<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></span>
</div>
<div class="body">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.id.label" default="Id"/></td>

                <td valign="top" class="value">${fieldValue(bean: personInstance, field: "id")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.preferredName.label" default="Preferred Name"/></td>

                <td valign="top" class="value">${fieldValue(bean: personInstance, field: "preferredName")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.honorific.label" default="Honorific"/></td>

                <td valign="top" class="value">${fieldValue(bean: personInstance, field: "honorific")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.firstGivenName.label" default="First Name"/></td>

                <td valign="top" class="value">${fieldValue(bean: personInstance, field: "firstGivenName")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.middleGivenNames.label" default="Middle Names"/></td>

                <td valign="top" class="value">${fieldValue(bean: personInstance, field: "middleGivenNames")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.familyName.label" default="Family Name"/></td>

                <td valign="top" class="value">${fieldValue(bean: personInstance, field: "familyName")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.suffix.label" default="Suffix"/></td>

                <td valign="top" class="value">${fieldValue(bean: personInstance, field: "suffix")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.photo.label" default="Photo"/></td>

                <td valign="top" class="value">
                    <g:if test="${personInstance?.photo}">
                        <img alt="photo" width="200px" height="150px" class="photo"
                                src="${createLink(controller: 'person', action: 'viewPhoto', id: personInstance?.id)}"/>
                        <br/>
                    </g:if>
                </td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.birthDate.label" default="Birth Date"/></td>

                <td valign="top" class="value"><g:formatDate date="${personInstance?.birthDate}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.connections.label" default="Places"/></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${personInstance.connections}" var="p">
                            <li><g:link controller="connection" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="person.comLinks.label" default="Com Links"/></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${personInstance.comLinks}" var="c">
                            <li><g:link controller="communicationLink" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            </tbody>
        </table>
    </div>
    <div class="buttons">
        <g:form>
            <g:hiddenField name="id" value="${personInstance?.id}"/>
            <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
            <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
        </g:form>
    </div>
</div>
</body>
</html>
