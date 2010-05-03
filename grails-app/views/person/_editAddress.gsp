
%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<%@ page import="com.getsu.wcy.Address" %>
<table>
<tbody>

<tr class="prop">
    <td valign="top" class="name">
        <g:hiddenField name="id" value="${addressInstance?.id}"/>
        <g:hiddenField name="version" value="${addressInstance?.version}"/>
        <a href="#" class="expander ExpandManager swapToUpperPreviousRow">V</a>
        <label for="streetType"><g:message code="address.streetType.label" default="Street Type" /></label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'streetType', 'errors')}">
        <g:checkBox name="streetType" value="${addressInstance?.streetType}" />
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="postalType"><g:message code="address.postalType.label" default="Postal Type" /></label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'postalType', 'errors')}">
        <g:checkBox name="postalType" value="${addressInstance?.postalType}" />
    </td>
</tr>

        <tr class="prop">
            <td valign="top" class="name">
              <label for="line1"><g:message code="address.line1.label" default="Line1" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'line1', 'errors')}">
                <g:textField name="line1" value="${addressInstance?.line1}" />
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
              <label for="line2"><g:message code="address.line2.label" default="Line2" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'line2', 'errors')}">
                <g:textField name="line2" value="${addressInstance?.line2}" />
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
              <label for="city"><g:message code="address.city.label" default="City" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'city', 'errors')}">
                <g:textField name="city" value="${addressInstance?.city}" />
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
              <label for="state"><g:message code="address.state.label" default="State" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'state', 'errors')}">
                <g:textField name="state" value="${addressInstance?.state}" />
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
              <label for="postalCode"><g:message code="address.postalCode.label" default="Postal Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'postalCode', 'errors')}">
                <g:textField name="postalCode" value="${addressInstance?.postalCode}" />
            </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
              <label for="countryCode"><g:message code="address.countryCode.label" default="Country Code" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: addressInstance, field: 'countryCode', 'errors')}">
                <g:textField name="countryCode" value="${addressInstance?.countryCode}" />
            </td>
        </tr>
</tbody>
</table>
