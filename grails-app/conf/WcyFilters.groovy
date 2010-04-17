/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

class WcyFilters {
    static nonAuthenticatedActions = [
            [controller: 'authentication', action: '*'],
            [controller: 'login', action: '*'],
            [controller: 'signup', action: '*']
    ]
    def filters = {
        accessFilter(controller: '*', action: '*') {
            before = {
                boolean needsAuth = !(boolean)nonAuthenticatedActions.find {
                    (it.controller == controllerName) && ((it.action == '*') || (it.action == actionName))
                }
                if (needsAuth) {
                    return applicationContext.authenticationService.filterRequest(
                            request, response,
                            "${request.contextPath}/login/index")
                } else return true
            }
        }
    }
}