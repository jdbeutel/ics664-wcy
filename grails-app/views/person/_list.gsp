%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<%@ page import="com.getsu.wcy.Person" %>
<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>
<div class="list">
    <table>
        <thead>
        <tr>

            <!--th><!--expand button  ></th-->

            <!-- sortableColumn must be a field that GORM can sort on -->
            <g:sortableColumn class="withExpandButton" property="name" title="${message(code: 'person.name.label', default: 'Name')}"/>

            <th>Email</th>

            <th>Phone</th>

            <th>Address</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${personInstanceList}" status="i" var="personInstance">
            <tr class="summary ${(i % 2) == 0 ? 'odd' : 'even'}">

                <!--td>
                    <a href="#" class="expander ExpandManager swapToNextRow">&gt;</a>
                </td-->

                <td>
                    <a href="#" class="expander ExpandManager swapToNextRow">&gt;</a>
                    ${fieldValue(bean: personInstance, field: "name")}
                </td>

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
            <tr style="display: none" class="detail ${(i % 2) == 0 ? 'odd' : 'even'}">
                <!--td>
                    <a href="#" class="expander ExpandManager swapToPreviousRow">V</a>
                </td-->
                <td colspan="4">
                    <div> <!-- Effect.BlindUp/Down requires this double div -->
                        <div>
                            <table>
                                <tbody>
                                    <g:render template="/person/editPerson" model="['personInstance':personInstance]"/>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
<div class="paginateButtons">
    <g:paginate total="${personInstanceTotal}"/>
</div>
