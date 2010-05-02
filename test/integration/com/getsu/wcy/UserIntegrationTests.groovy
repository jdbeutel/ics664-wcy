/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

import grails.test.GrailsUnitTestCase
import grails.validation.ValidationException

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
}
