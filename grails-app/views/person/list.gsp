
<%@ page import="com.getsu.wcy.Person" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'person.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="preferredName" title="${message(code: 'person.preferredName.label', default: 'Preferred Name')}" />
                        
                            <g:sortableColumn property="honorific" title="${message(code: 'person.honorific.label', default: 'Honorific')}" />
                        
                            <g:sortableColumn property="givenNames" title="${message(code: 'person.givenNames.label', default: 'Given Names')}" />
                        
                            <g:sortableColumn property="familyName" title="${message(code: 'person.familyName.label', default: 'Family Name')}" />
                        
                            <g:sortableColumn property="suffix" title="${message(code: 'person.suffix.label', default: 'Suffix')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${personInstanceList}" status="i" var="personInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${personInstance.id}">${fieldValue(bean: personInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: personInstance, field: "preferredName")}</td>
                        
                            <td>${fieldValue(bean: personInstance, field: "honorific")}</td>
                        
                            <td>${fieldValue(bean: personInstance, field: "givenNames")}</td>
                        
                            <td>${fieldValue(bean: personInstance, field: "familyName")}</td>
                        
                            <td>${fieldValue(bean: personInstance, field: "suffix")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${personInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
