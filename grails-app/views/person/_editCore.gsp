%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
<tr class="prop">
    <td valign="top" class="name">
        <g:hiddenField name="id" value="${personInstance?.id}" />
        <g:hiddenField name="version" value="${personInstance?.version}" />
        <g:hiddenField name="originalValuesJSON" value="${personInstance?.originalValuesJSON}"/>
        <label for="preferredName"><g:message code="person.preferredName.label" default="Nickname" /></label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'preferredName', 'errors')}">
        <g:textField name="preferredName" value="${personInstance?.preferredName}" />
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="honorific"><g:message code="person.honorific.label" default="Honorific (e.g., Mr.)" /></label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'honorific', 'errors')}">
        <g:textField name="honorific" value="${personInstance?.honorific}" />
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="required name">
        <label for="firstGivenName"><g:message code="person.firstGivenName.label" default="First Name" /></label>
    </td>
    <td valign="top" class="required value ${hasErrors(bean: personInstance, field: 'firstGivenName', 'errors')}">
        <g:textField name="firstGivenName" value="${personInstance?.firstGivenName}" /> <wcy:required/>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="middleGivenNames"><g:message code="person.middleGivenNames.label" default="Middle Names" /></label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'middleGivenNames', 'errors')}">
        <g:textField name="middleGivenNames" value="${personInstance?.middleGivenNames}" />
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="required name">
        <label for="familyName"><g:message code="person.familyName.label" default="Last Name" /></label>
    </td>
    <td valign="top" class="required value ${hasErrors(bean: personInstance, field: 'familyName', 'errors')}">
        <g:textField name="familyName" value="${personInstance?.familyName}" /> <wcy:required/>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="suffix"><g:message code="person.suffix.label" default="Suffix (e.g., Jr.)" /></label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'suffix', 'errors')}">
        <g:textField name="suffix" value="${personInstance?.suffix}" />
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="required name">
        <label for="photoUpload"><g:message code="person.photo.label" default="Photo" /></label>
    </td>
    <td valign="top" class="required value ${hasErrors(bean: personInstance, field: 'photo', 'errors')}">
        <g:if test="${personInstance?.photo}">
            <img alt="photo" width="200px" height="150px" class="photo"
                    src="${createLink(controller:'person', action:'viewPhoto', id:personInstance?.id)}" />
            <br/>
        </g:if>
        <input type="file" id="photoUpload" name="photoUpload"/> <wcy:required/>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="birthDate"><g:message code="person.birthDate.label" default="Birth Date" /></label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'birthDate', 'errors')}">
        <g:datePicker name="birthDate" precision="day" value="${personInstance?.birthDate}" noSelection="['': '']" />
    </td>
</tr>


