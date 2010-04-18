package com.getsu.wcy

class SettingsController {

    static navigation = [group:'tabs', order:60, title:'settings']

    static allowedMethods = [update: "POST"]

    def authenticationService

    def index = {
        // testing
        def login = auth.user()
        assert authenticationService.isLoggedIn(request)
        User user = authenticationService.userPrincipal
        assert login == user.login

        redirect(action: "edit", params: params)
    }

    def edit = {
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        User user = authenticationService.userPrincipal
        def settingsInstance = user.settings
        return [settingsInstance: settingsInstance]
    }

    def update = {
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        User user = authenticationService.userPrincipal
        def settingsInstance = user.settings
        assert settingsInstance // constraint of User
        if (params.version) {
            def version = params.version.toLong()
            if (settingsInstance.version > version) {

                settingsInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'settings.label', default: 'Settings')] as Object[], "Another user has updated this Settings while you were editing")
                render(view: "edit", model: [settingsInstance: settingsInstance])
                return
            }
        }
        settingsInstance.properties = params
        if (!settingsInstance.hasErrors() && settingsInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.updated.message', args: [message(code: 'settings.label', default: 'Settings'), settingsInstance.id])}"
            redirect(action: "edit", id: settingsInstance.id)
        }
        else {
            render(view: "edit", model: [settingsInstance: settingsInstance])
        }
    }
}
