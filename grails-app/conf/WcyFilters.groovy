/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

class WcyFilters {
    static nonAuthenticatedActions = [
            [controller: 'authentication', action: '*'], // plugin
            [controller: 'auth', action: '*'] // mine
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
                            "${request.contextPath}/auth/login")
                } else return true
            }
        }
    }
}