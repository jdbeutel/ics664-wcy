package com.getsu.wcy

import java.text.SimpleDateFormat

class SettingsController {

    static navigation = [group:'tabs', order:60, title:'settings']

    static allowedMethods = [update:"POST", editPassword:"POST", updatePassword:"POST"]

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

    def resumeEdit = { SettingsForm sf -> // after updatePassword
        render(view: "edit", model: [settingsForm:sf])
    }

    def update = { SettingsForm sf ->
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        // not using params.id because one can edit only one's own Settings
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
        if (!sf.validate()) {
            render(view: "edit", model: [settingsForm:sf]) // failure, try again, displaying sf errors
            return
        }
        user.settings.dateFormat = sf.dateFormat
        user.settings.timeZone = sf.timeZone
        user.login = sf.loginEmail
        user.save(flush:true, failOnError:true)
        flash.message = "${message(code: 'default.updated.message', args: [message(code: 'settings.label', default: 'Settings'), user.id])}"
        redirect(action: "edit") // success, but always editing anyway
    }

    def editPassword = { PasswordForm pf ->
        pf.clearErrors() // save Settings edit params without validation for resume later
        [passwordForm:pf]
    }

    def updatePassword = { PasswordForm pf ->
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        // not using params.id because one can edit only one's own password
        User user = authenticationService.userPrincipal
        if (user.password != authenticationService.encodePassword(pf.oldPassword)) { // extra authentication
            pf.errors.rejectValue("oldPassword", "passwordForm.oldPassword.mismatch")
            render(view: "editPassword", model: [passwordForm:pf]) // failure, show pf.errors and try again
            return
        }
        if (!authenticationService.checkPassword(pf.newPassword)) { // for consistency with signup
            pf.errors.rejectValue("newPassword", "passwordForm.newPassword.unacceptable", "The new password is unacceptable")
            render(view: "editPassword", model: [passwordForm:pf]) // failure, show pf.errors and try again
            return
        }
        if (!pf.validate()) { // constraints check that newPasswordConfirm matches
            render(view: "editPassword", model: [passwordForm:pf]) // failure, show pf.errors and try again
            return
        }
        user.password = authenticationService.encodePassword(pf.newPassword)
        user.save(flush:true, failOnError:true)
        flash.message = "Password updated"
        def savedSettingsParams = pf.resumeParams() + [userVersion: user.version] // user.version incremented by save
        redirect(action: "resumeEdit", params:savedSettingsParams) // success
    }
}

class SettingsForm {
    String loginEmail
    long userVersion

    SimpleDateFormat dateFormat
    TimeZone timeZone
    long settingsVersion

    static constraints = {
        loginEmail(size:6..40, email:true, blank:false, nullable:false)
    }
}

class PasswordForm {
    String oldPassword
    String newPassword
    String newPasswordConfirm
    // user version doesn't matter as long as the oldPassword matches

    // save the following without validation for resumeEdit to SettingsForm
    String loginEmail
    String dateFormat
    String timeZone
    long settingsVersion
    Map resumeParams() {
        [loginEmail:loginEmail, dateFormat:dateFormat, timeZone:timeZone, settingsVersion:settingsVersion]
    }

    static constraints = {
        newPassword(size:6..40, password:true, blank:false, nullable:false)
        newPasswordConfirm(password:true, blank:false, nullable:false, validator: { val, obj -> obj.newPassword == val })
    }
}
