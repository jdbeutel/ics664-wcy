%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<%@ page import="com.getsu.wcy.Person" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'contact.label', default: 'Contact')}"/>
  <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>

        <!-- sortableColumn must be a field that GORM can sort on -->
          <g:sortableColumn property="name" title="${message(code: 'person.name.label', default: 'Name')}" />

        <th>Email</th>

        <th>Phone</th>

        <th>Address</th>

      </tr>
      </thead>
      <tbody>
      <g:each in="${personInstanceList}" status="i" var="personInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td>${fieldValue(bean: personInstance, field: "name")}</td>

          <td>
            <g:if test="${personInstance.preferredEmail}">
              ${fieldValue(bean: personInstance, field: "preferredEmail.type")}
              ${fieldValue(bean: personInstance, field: "preferredEmail.address")}
            </g:if>
          </td>

          <td>
            <g:if test="${personInstance.preferredPhone}">
              ${fieldValue(bean: personInstance, field: "preferredPhone.type")}
              ${fieldValue(bean: personInstance, field: "preferredPhone.number")}
            </g:if>
          </td>

          <td>
            <g:if test="${personInstance.preferredConnection}">
              ${fieldValue(bean: personInstance.preferredConnection, field: "type")}
              ${fieldValue(bean: personInstance.preferredConnection?.place?.addresses[0], field: "line1")}
              ${fieldValue(bean: personInstance.preferredConnection?.place?.addresses[0], field: "line2")}
              ${fieldValue(bean: personInstance.preferredConnection?.place?.addresses[0], field: "city")},
              ${fieldValue(bean: personInstance.preferredConnection?.place?.addresses[0], field: "state")}
              ${fieldValue(bean: personInstance.preferredConnection?.place?.addresses[0], field: "postalCode")}
              ${fieldValue(bean: personInstance.preferredConnection?.place?.addresses[0], field: "countryCode")}
            </g:if>
          </td>

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
