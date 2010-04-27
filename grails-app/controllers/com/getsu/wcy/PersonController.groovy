package com.getsu.wcy

import org.springframework.web.multipart.MultipartFile

class PersonController {

    static navigation = [group:'tabs', order:30, title:'my profile', action:'editMyProfile']

    static allowedMethods = [save: "POST", update: "POST", updateMyProfile:"POST", delete: "POST"]

    def authenticationService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [personInstanceList: Person.list(params), personInstanceTotal: Person.count()]
    }

    def create = {
        def personInstance = new Person()
        personInstance.properties = params
        return [personInstance: personInstance]
    }

    def save = {
        def personInstance = new Person(params)
        if (personInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])}"
            redirect(action: "show", id: personInstance.id)
        }
        else {
            render(view: "create", model: [personInstance: personInstance])
        }
    }

    def show = {
        def personInstance = Person.get(params.id)
        if (!personInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
            redirect(action: "list")
        }
        else {
            [personInstance: personInstance]
        }
    }

    def edit = {
        def personInstance = Person.get(params.id)
        if (!personInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [personInstance: personInstance]
        }
    }

    def update = {
        def personInstance = Person.get(params.id)
        if (personInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (personInstance.version > version) {

                    personInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'person.label', default: 'Person')] as Object[], "Another user has updated this Person while you were editing")
                    render(view: "edit", model: [personInstance: personInstance])
                    return
                }
            }
            personInstance.properties = params
            if (!personInstance.hasErrors() && personInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])}"
                redirect(action: "show", id: personInstance.id)
            }
            else {
                render(view: "edit", model: [personInstance: personInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
            redirect(action: "list")
        }
    }

    def editMyProfile = {
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        User user = authenticationService.userPrincipal
        assert user.person // User constraint
        return [personInstance:user.person]
    }

    public static getOriginalFileName(MultipartFile uploadedFile) {
        char otherSeparatorChar = (char) (File.separatorChar == '/' ? '\\' : '/')
        return new File(uploadedFile.originalFilename.replace(otherSeparatorChar, File.separatorChar)).name
    }

    def updateMyProfile = {
        assert authenticationService.isLoggedIn(request) // otherwise the filter would have redirected
        User user = authenticationService.userPrincipal
        assert user.person // User constraint
        def personInstance = user.person
        if (personInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (personInstance.version > version) {
                    
                    personInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'person.label', default: 'Person')] as Object[], "Another user has updated this Person while you were editing")
                    render(view: "editMyProfile", model: [personInstance: personInstance])
                    return
                }
            }
            personInstance.properties = params
            MultipartFile uploadedFile = request.getFile('photoUpload')
            if (uploadedFile?.size) { // avoids overwriting existing photo if not uploading a new one
                // todo: if (uploadedFile.size > UPLOAD_LIMIT) { flash.message = "Photo too big" ... }
                personInstance.photo = uploadedFile.bytes
                personInstance.photoFileName = getOriginalFileName(uploadedFile)
            }
            // todo: remember photo from previous tries and provide it for display
            // todo: validate file image format and scale down if too big?
            if (!personInstance.hasErrors() && personInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'person.label', default: 'Person'), personInstance.id])}"
                redirect(action: "editMyProfile", id: personInstance.id) // success, but always editing
            }
            else {
                render(view: "editMyProfile", model: [personInstance: personInstance]) // failure, display errors
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
            redirect(action: "list")
        }
    }

    def viewPhoto = {
        Person p = Person.get(params.id)
        // todo: check access authorization
        response.setHeader("Content-disposition", "attachment; filename=${p.photoFileName}")
        // response.contentType = photo.fileType //'image/jpeg' will do too
        response.outputStream << p.photo
        response.outputStream.flush()
        return;
    }

    def delete = {
        def personInstance = Person.get(params.id)
        if (personInstance) {
            try {
                personInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])}"
            redirect(action: "list")
        }
    }
}
