
%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<%@ page import="com.getsu.wcy.Address" %>
<table>
<tbody>

<td colspan="2">
    <g:hiddenField name="id" value="${connectionInstance?.id}"/>
    <g:hiddenField name="version" value="${connectionInstance?.version}"/>
    <a href="#" class="expander ExpandManager swapToUpperPreviousRow">V</a>
    <span class="name">${fieldValue(bean: connectionInstance, field: "type")}</span>
</td>

<g:each in="${connectionInstance?.emailAddresses}" var="emailAddressInstance">
    <tr class="prop">
        <td valign="top" class="name">
            <label for="address">Direct Email</label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: emailAddressInstance, field: 'address', 'errors')}">
            <g:textField name="address" value="${emailAddressInstance?.address}" />
        </td>
    </tr>
</g:each>
<g:each in="${connectionInstance?.phoneNumbers}" var="phoneNumberInstance">
    <tr class="prop">
        <td valign="top" class="name">
            <label for="number">Direct ${phoneNumberInstance.type}</label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: phoneNumberInstance, field: 'number', 'errors')}">
            <g:textField name="number" value="${phoneNumberInstance?.number}" />
        </td>
    </tr>
</g:each>

<g:each in="${connectionInstance?.place?.addresses}" var="addressInstance">

    <tr class="prop">
        <td valign="top" class="name">
            <a href="#" class="expander ExpandManager swapToNextRow">&gt;</a>
            <label for="address">${addressInstance.type} Address</label>
        </td>
        <td valign="top" class="value">
            ${fieldValue(bean: addressInstance, field: "line1")}
            ${fieldValue(bean: addressInstance, field: "line2")}
            ${fieldValue(bean: addressInstance, field: "city")},
            ${fieldValue(bean: addressInstance, field: "state")}
            ${fieldValue(bean: addressInstance, field: "postalCode")}
            ${fieldValue(bean: addressInstance, field: "countryCode")}
        </td>
    </tr>
    <tr style="display: none" class="detail">
        <td colspan="2">
            <div> <!-- Effect.BlindUp/Down requires this double div -->
                <div>
                    <g:render template="/person/editAddress" model="['addressInstance':addressInstance]"/>
                </div>
            </div>
        </td>
    </tr>
</g:each>

<g:each in="${connectionInstance?.place?.emailAddresses}" var="emailAddressInstance">
    <tr class="prop">
        <td valign="top" class="name">
            <label for="address">Email</label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: emailAddressInstance, field: 'address', 'errors')}">
            <g:textField name="address" value="${emailAddressInstance?.address}" />
        </td>
    </tr>
</g:each>
<g:each in="${connectionInstance?.place?.phoneNumbers}" var="phoneNumberInstance">
    <tr class="prop">
        <td valign="top" class="name">
            <label for="number">${phoneNumberInstance.type}</label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: phoneNumberInstance, field: 'number', 'errors')}">
            <g:textField name="number" value="${phoneNumberInstance?.number}" />
        </td>
    </tr>
</g:each>

<tr class="prop">
    <td valign="top" class="name">
        <label for="add">Add</label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'birthDate', 'errors')}">
        <g:select name="add" from="${['what?', 'email', 'phone', 'address', 'instant messenger', 'skype', 'twitter']}"/>
    </td>
</tr>
</tbody>
</table>
