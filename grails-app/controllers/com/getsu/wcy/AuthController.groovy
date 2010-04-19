/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

/**
 * just views delegating to the authentication plugin
 */
class AuthController {

    def authenticationService

    static navigation = [
		[group:'authOptions', action:'logout', title:'logout', order:99, isVisible:{ authenticationService.isLoggedIn(request) }]
	]

    def index = {
        redirect(action: "login", params: params)
    }

    def login = { }

    def signup = { }

    def logout = {
        authenticationService.logout( authenticationService.sessionUser )
    }

    def forgot = { }
}
