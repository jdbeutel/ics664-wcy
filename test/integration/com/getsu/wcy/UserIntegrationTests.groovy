/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

import grails.test.GrailsUnitTestCase
import grails.validation.ValidationException
import com.getsu.wcy.Connection.ConnectionType

class UserIntegrationTests extends GrailsUnitTestCase {

    void testSave() {
        User u = User.createSignupInstance('foo@bar.com')
        u.password = 'my password'
        if (!u.save(flush:true)) {
            fail(u.errors.allErrors.collect {it.code}.join(', '))
        }
        assert u.id
    }

    void testValidatePerson() {
        User u = User.createSignupInstance('foo@bar.com')
        u.password = 'my password'
        u.person.firstGivenName = '' // looking for the blank error
        assert !u.person.validate()
        assert u.person.errors.allErrors.collect {it.code}.contains('blank')
        assert !u.validate(deepValidate:true)

        // Config.groovy's grails.gorm.failOnError = true does not work for cascades,
        // but it does work thanks to User's person validator: { it?.validate() } constraint.
        shouldFail(ValidationException) {
            u.save()
        }
    }

    void testDeepValidatePerson() {
        User u = User.createSignupInstance('foo@bar.com')
        u.password = 'my password'
        assert u.validate() // defaults to deepValidate:true
        assert !u.person.errors.allErrors.collect {it.code}.contains('blank')
        u.person.firstGivenName = '' // looking for the blank error
        assert !u.validate() // defaults to deepValidate:true
        assert u.person.errors.allErrors.collect {it.code}.contains('blank')
        assert !u.person.validate()
        shouldFail(ValidationException) {
            u.save()
        }
    }

    void testValidateConnection() {
        User u = User.createSignupInstance('foo@bar.com')
        u.password = 'my password'
        assert u.validate()
        def connErrors = u.person.connections[0].errors.allErrors
        assert !connErrors.collect {it.code}.contains('nullable')

        u.person.connections[0].type = null
        assert !u.validate()
        connErrors = u.person.connections[0].errors.allErrors
        assert connErrors.collect {it.code}.contains('nullable')
        shouldFail(ValidationException) {
            u.save()
        }
        u.person.connections[0].type = ConnectionType.HOME
        assert u.validate()
        u.save()
    }

    void testValidateAddress() {
        User u = User.createSignupInstance('foo@bar.com')
        u.password = 'my password'
        assert u.person.connections[0].place.addresses[0].city == 'during signup'
        assert u.validate()
        assert !u.person.connections[0].place.addresses[0].errors.allErrors.collect {it.code}.contains('blank')
        u.save()
        u.person.connections[0].place.addresses[0].city = ''
        assert !u.validate()
        def addrErrors = u.person.connections[0].place.addresses[0].errors.allErrors
        assert addrErrors.collect {it.code}.contains('blank')
        shouldFail(ValidationException) {
            u.save()
        }
        u.person.connections[0].place.addresses[0].city = 'Honolulu'
        assert u.validate()
        u.save()
    }
}
