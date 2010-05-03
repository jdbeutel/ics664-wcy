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
        ${fieldValue(bean: personInstance, field: "name")}
    </td>
    <td>
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
<tr class="prop">
    <td valign="top" class="required name">
        <label for="photoUpload"><g:message code="person.photo.label" default="Photo"/></label>
    </td>
    <td valign="top" class="required value ${hasErrors(bean: personInstance, field: 'photo', 'errors')}">
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
    <td valign="top" class="value ${hasErrors(bean: personInstance, field: 'birthDate', 'errors')}">
        <g:datePicker name="birthDate" precision="day" value="${personInstance?.birthDate}" noSelection="['': '']"/>
    </td>
</tr>
</tbody>
</table>

