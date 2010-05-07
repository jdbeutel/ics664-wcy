%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<table>
<tbody>
<tr>
    <td>
        <g:hiddenField name="id" value="${personInstance?.id}"/>
        <g:hiddenField name="version" value="${personInstance?.version}"/>
        <g:hiddenField name="originalValuesJSON" value="${personInstance?.originalValuesJSON}"/>
        <a href="#" class="expander ExpandManager swapToUpperPreviousRow">V</a>
        <span class="name">${fieldValue(bean: personInstance, field: "name")}</span>
    </td>
    <td colspan="3">
        <div>
            <a href="#" class="expander ExpandManager swapToNextDiv">&gt;</a>
            (
            ${personInstance?.honorific}
            ${personInstance?.firstGivenName}
            <g:if test="${personInstance?.preferredName}">
                (${personInstance?.preferredName})
            </g:if>
            ${personInstance?.middleGivenNames}
            ${personInstance?.familyName}${personInstance?.suffix ? ',' : ''}
            ${personInstance?.suffix}
            )
        </div>
        <div style="display:none">
            <div>
                <g:render template="/person/editName" model="['personInstance':personInstance]"/>
            </div>
        </div>
    </td>
</tr>

<g:each in="${personInstance?.emailAddresses}" var="emailAddressInstance">
  <tr class="prop">
    <td valign="top" class="name">
      <label for="address">Personal Email</label>
    </td>
    <td colspan="3" valign="top" class="value ${hasErrors(bean: emailAddressInstance, field: 'address', 'errors')}">
      <g:textField name="address" value="${emailAddressInstance?.address}" />
    </td>
  </tr>
</g:each>
<g:each in="${personInstance?.phoneNumbers}" var="phoneNumberInstance">
  <tr class="prop">
    <td valign="top" class="name">
      <label for="number">Personal ${phoneNumberInstance.type}</label>
    </td>
    <td colspan="3" valign="top" class="value ${hasErrors(bean: phoneNumberInstance, field: 'number', 'errors')}">
      <g:textField name="number" value="${phoneNumberInstance?.number}" />
    </td>
  </tr>
</g:each>

<g:render template="/person/listConnections" model="['personInstance':personInstance]"/>

<tr class="prop">
    <td valign="top" class="required name">
        <label for="photoUpload"><g:message code="person.photo.label" default="Photo"/></label>
    </td>
    <td colspan="3" valign="top" class="required value ${hasErrors(bean: personInstance, field: 'photo', 'errors')}">
        <g:if test="${personInstance?.photo}">
            <img alt="photo" height="100px" width="133px" class="photo"
                    src="${createLink(controller: 'person', action: 'viewPhoto', id: personInstance?.id)}"/>
            <br/>
        </g:if>
        <input type="file" id="photoUpload" name="photoUpload"/> <wcy:required/>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="birthDate"><g:message code="person.birthDate.label" default="Birth Date"/></label>
    </td>
    <td colspan="3" valign="top" class="value ${hasErrors(bean: personInstance, field: 'birthDate', 'errors')}">
        <g:datePicker name="birthDate" precision="day" value="${personInstance?.birthDate}" noSelection="['': '']"/>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="add">Add</label>
    </td>
    <td colspan="3" valign="top" class="value ${hasErrors(bean: personInstance, field: 'birthDate', 'errors')}">
        <g:select name="add" from="${['what?', 'email', 'phone', 'address', 'instant messenger', 'skype', 'twitter']}"/>
    </td>
</tr>

<tr class="prop">
    <td colspan="4" valign="top">
        <span class="button"><g:actionSubmit class="editPerson" action="update" value="Save"/></span>
    </td>
</tr>
</tbody>
</table>

