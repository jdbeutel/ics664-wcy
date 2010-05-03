%{--
  - Copyright (c) 2010 J. David Beutel <software@getsu.com>
  -
  - Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
  --}%
        <g:each in="${personInstance?.connections?.sort{it.type}}" status="i" var="connectionInstance">
            <tr class="summary ${(i % 2) == 0 ? 'odd' : 'even'}">

                <td>
                    <a href="#" class="expander ExpandManager swapToNextRow">&gt;</a>
                    ${fieldValue(bean: connectionInstance, field: "type")}
                </td>

                <td>
                    <g:if test="${connectionInstance.preferredEmail}">
                        ${fieldValue(bean: connectionInstance, field: "preferredEmail.type")}
                        ${fieldValue(bean: connectionInstance, field: "preferredEmail.address")}
                    </g:if>
                </td>

                <td>
                    <g:if test="${connectionInstance.preferredPhone}">
                        ${fieldValue(bean: connectionInstance, field: "preferredPhone.type")}
                        ${fieldValue(bean: connectionInstance, field: "preferredPhone.number")}
                    </g:if>
                </td>

                <td>
                    <g:if test="${connectionInstance.preferredAddress}">
                        ${fieldValue(bean: connectionInstance.preferredAddress, field: "line1")}
                        ${fieldValue(bean: connectionInstance.preferredAddress, field: "line2")}
                        ${fieldValue(bean: connectionInstance.preferredAddress, field: "city")},
                        ${fieldValue(bean: connectionInstance.preferredAddress, field: "state")}
                        ${fieldValue(bean: connectionInstance.preferredAddress, field: "postalCode")}
                        ${fieldValue(bean: connectionInstance.preferredAddress, field: "countryCode")}
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
                            <g:render template="/person/editConnection" model="['connectionInstance':connectionInstance]"/>
                        </div>
                    </div>
                </td>
            </tr>
        </g:each>
