package com.getsu.wcy

class NotificationController {

    static navigation = [group:'tabs', order:40, title:'notifications']

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def authenticationService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        User user = authenticationService.userPrincipal
        params.max = Math.min(params.max ? params.int('max') : 10, 100) // defends against too big (DOS attack)
        def notificationInstanceList = Notification.withCriteria {
            eq 'recipient', user
            maxResults(params.max?.toInteger())
            firstResult(params.offset?.toInteger() ?: 0)
            switch (params.sort) {
                case 'subject.person.name':
                    subject {
                        person {
                            order('name', params.order)
                        }
                    }
                    break;
                case 'object.name':
                    object {
                        order('name', params.order)
                    }
                    break;
                default:
                    order(params.sort ?: 'date', params.order ?: 'desc')
            }
        }
        [notificationInstanceList:notificationInstanceList, notificationInstanceTotal: Notification.countByRecipient(user)]
    }

    def create = {
        def notificationInstance = new Notification()
        notificationInstance.properties = params
        return [notificationInstance: notificationInstance]
    }

    def save = {
        def notificationInstance = new Notification(params)
        if (notificationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'notification.label', default: 'Notification'), notificationInstance.id])}"
            redirect(action: "show", id: notificationInstance.id)
        }
        else {
            render(view: "create", model: [notificationInstance: notificationInstance])
        }
    }

    def show = {
        def notificationInstance = Notification.get(params.id)
        if (!notificationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'notification.label', default: 'Notification'), params.id])}"
            redirect(action: "list")
        }
        else {
            [notificationInstance: notificationInstance]
        }
    }

    def edit = {
        def notificationInstance = Notification.get(params.id)
        if (!notificationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'notification.label', default: 'Notification'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [notificationInstance: notificationInstance]
        }
    }

    def update = {
        def notificationInstance = Notification.get(params.id)
        if (notificationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (notificationInstance.version > version) {
                    
                    notificationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'notification.label', default: 'Notification')] as Object[], "Another user has updated this Notification while you were editing")
                    render(view: "edit", model: [notificationInstance: notificationInstance])
                    return
                }
            }
            notificationInstance.properties = params
            if (!notificationInstance.hasErrors() && notificationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'notification.label', default: 'Notification'), notificationInstance.id])}"
                redirect(action: "show", id: notificationInstance.id)
            }
            else {
                render(view: "edit", model: [notificationInstance: notificationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'notification.label', default: 'Notification'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def notificationInstance = Notification.get(params.id)
        if (notificationInstance) {
            try {
                notificationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'notification.label', default: 'Notification'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'notification.label', default: 'Notification'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'notification.label', default: 'Notification'), params.id])}"
            redirect(action: "list")
        }
    }
}
