package com.getsu.wcy

import java.text.SimpleDateFormat

class SettingsController {

    static navigation = [group:'tabs', order:60, title:'settings']

    static allowedMethods = [update:"POST"]

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

        f.changePassword = false
        f.oldPassword = ''
        f.newPassword = ''
        f.newPasswordConfirm = ''

        f.dateFormat = user.settings.dateFormat
        f.timeZone = user.settings.timeZone
        f.settingsVersion = user.settings.version

        return [settingsForm:f]
    }

    def update = { SettingsForm sf ->
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        // not using params.id nor params.settings.id/params.user.id because one can edit only one's own User/Settings
        User user = authenticationService.userPrincipal
        if (user.version > sf.userVersion) {
            sf.errors.rejectValue("userVersion", "default.optimistic.locking.failure", [message(code: 'settings.label', default: 'Settings')] as Object[], "Another user has updated this Settings while you were editing")
            render(view: "edit", model: [settingsForm:sf]) // failure, trying again won't help, but do redisplay the edited data
            return
        }
        if (user.settings.version > sf.settingsVersion) {
            sf.errors.rejectValue("settingsVersion", "default.optimistic.locking.failure", [message(code: 'settings.label', default: 'Settings')] as Object[], "Another user has updated this Settings while you were editing")
            render(view: "edit", model: [settingsForm:sf]) // failure, trying again won't help, but do redisplay the edited data
            return
        }
        if (sf.changePassword) {
            if (user.password != authenticationService.encodePassword(sf.oldPassword)) { // extra authentication
                sf.errors.rejectValue("oldPassword", "settingsForm.oldPassword.mismatch")
                render(view: "edit", model: [settingsForm:sf]) // failure, show errors and try again
                return
            }
            sf.newPassword = sf.newPassword.trim() // todo: see if grails does this automatically
            if (!sf.newPassword) {
                sf.errors.rejectValue("newPassword", "settingsForm.newPassword.missing", "Please type in a new password")
                render(view: "edit", model: [settingsForm:sf]) // failure, show errors and try again
                return
            }
            if (![6..40].contains(sf.newPassword.size())) {
                sf.errors.rejectValue("newPassword", "settingsForm.newPassword.length", "New password needs between 6 and 40 characters")
                render(view: "edit", model: [settingsForm:sf]) // failure, show errors and try again
                return
            }
            if (!authenticationService.checkPassword(sf.newPassword)) { // for consistency with signup
                sf.errors.rejectValue("newPassword", "settingsForm.newPassword.unacceptable", "The new password is unacceptable")
                render(view: "edit", model: [settingsForm:sf]) // failure, show errors and try again
                return
            }
            if (sf.newPassword != sf.newPasswordConfirm) {
                sf.errors.rejectValue("newPasswordConfirm", "settingsForm.newPasswordConfirm.mismatch", "New password not confirmed.  Please type in your new password again")
                render(view: "edit", model: [settingsForm:sf]) // failure, show errors and try again
                return
            }
            if (!sf.validate()) { // constraints check that newPasswordConfirm matches
                render(view: "edit", model: [settingsForm:sf]) // failure, show errors and try again
                return
            }
        }
        if (!sf.validate()) {
            render(view: "edit", model: [settingsForm:sf]) // failure, try again, displaying sf errors
            return
        }
        user.settings.dateFormat = sf.dateFormat
        user.settings.timeZone = sf.timeZone
        user.login = sf.loginEmail
        if (sf.changePassword) {
            user.password = authenticationService.encodePassword(sf.newPassword)
            flash.message = "Password changed"
        } else {
            flash.message = "Settings changed"
        }
        user.save(flush:true, failOnError:true)
        redirect(action: "edit") // success, but stay on the same tab anyway
    }
}

class SettingsForm {
    String loginEmail
    long userVersion

    SimpleDateFormat dateFormat
    TimeZone timeZone
    long settingsVersion

    boolean changePassword
    // optional if !changePassword
    String oldPassword
    String newPassword
    String newPasswordConfirm

    static constraints = {
        loginEmail(size:6..40, email:true, blank:false, nullable:false)
        newPassword(password:true, blank:false, nullable: true)
        newPasswordConfirm(password:true, blank:false, nullable:true)
    }
}
