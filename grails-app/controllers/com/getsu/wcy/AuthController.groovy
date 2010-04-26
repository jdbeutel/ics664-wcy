/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

import com.grailsrocks.authentication.SignupForm
import com.grailsrocks.authentication.AuthenticatedUser
import org.springframework.web.multipart.MultipartFile

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

    def doSignup = { Person p, SignupForm sf ->
        if (!p.validate() || sf.hasErrors()) { // todo: consistent validate & hasErrors?
            render(view:'signup', model:[personInstance:p, signupForm:sf]) // try again
            return
        }
        MultipartFile uploadedFile = request.getFile('photo')
        if (uploadedFile) {
            params.photoFileName = PersonController.getOriginalFileName(uploadedFile)
        }
        def signupResult = authenticationService.signup( login:sf.login,
                password:sf.password, email:sf.email, immediate:true, extraParams:params)
        if ((signupResult.result == 0) || (signupResult.result == AuthenticatedUser.AWAITING_CONFIRMATION)) {
            // onSignup event in BootStrap updates and saves the new user's person with params
            if (log.debugEnabled) {
                if (signupResult == AuthenticatedUser.AWAITING_CONFIRMATION) {
                    log.debug("Signup succeeded pending email confirmation for [${sf.login}] / [${sf.email}]")
                } else {
                    log.debug("Signup succeeded for [${sf.login}]")
                }
            }
            redirect(controller:'contact', action:'index') // success
        } else {
            sf.errors.rejectValue("authenticationFailure", "authentication.failure.${signupResult.result}")
            render(view:'signup', model:[personInstance:p, signupForm:sf]) // try again
        }
    }

    def logout = {
        authenticationService.logout( authenticationService.sessionUser )
    }

    def forgot = { }
}
