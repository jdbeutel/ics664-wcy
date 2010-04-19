package com.getsu.wcy

import java.text.SimpleDateFormat

class SettingsController {

    static navigation = [group:'tabs', order:60, title:'settings']

    static allowedMethods = [update: "POST"]

    def authenticationService

    def index = {
        redirect(action: "edit", params: params)
    }

    def edit = {
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        // not using params.id because one can edit only one's own Settings
        User user = authenticationService.userPrincipal
        def f = new SettingsForm()
        f.loginEmail = user.login
        f.userVersion = user.version
        f.dateFormat = user.settings.dateFormat
        f.timeZone = user.settings.timeZone
        f.settingsVersion = user.settings.version
        return [settingsForm:f]
    }

    def update = { SettingsForm f ->
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        // not using params.id because one can edit only one's own Settings
        User user = authenticationService.userPrincipal
        if (user.version > f.userVersion) {
            f.errors.rejectValue("userVersion", "default.optimistic.locking.failure", [message(code: 'settings.label', default: 'Settings')] as Object[], "Another user has updated this Settings while you were editing")
            render(view: "edit", model: [settingsForm:f]) // failure, trying again won't help, but do redisplay the edited data
            return
        }
        if (user.settings.version > f.settingsVersion) {
            f.errors.rejectValue("settingsVersion", "default.optimistic.locking.failure", [message(code: 'settings.label', default: 'Settings')] as Object[], "Another user has updated this Settings while you were editing")
            render(view: "edit", model: [settingsForm:f]) // failure, trying again won't help, but do redisplay the edited data
            return
        }
        if (!f.validate()) {
            render(view: "edit", model: [settingsForm:f]) // failure, try again
            return
        }
        user.settings.dateFormat = f.dateFormat
        user.settings.timeZone = f.timeZone
        user.login = f.loginEmail
        if (f.passwordChange) {
            user.password = authenticationService.encodePassword(f.passwordChange)
        }
        user.save(flush:true, failOnError:true)
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'settings.label', default: 'Settings'), user.id])}"
        redirect(action: "edit") // success, but always editing anyway
    }
}

class SettingsForm {
    
    String loginEmail
    String passwordChange
    String passwordChangeConfirm
    long userVersion
    
    SimpleDateFormat dateFormat
    TimeZone timeZone
    long settingsVersion

    static constraints = {
        loginEmail(size:6..40, email:true, blank:false, nullable:false)
        passwordChange(size:6..40, password:true, blank:true, nullable:true)
        passwordChangeConfirm(password:true, validator: { val, obj -> obj.passwordChange == val })
    }
}
