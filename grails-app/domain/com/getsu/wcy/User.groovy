/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

import java.text.SimpleDateFormat

class User {

    // next 4 are required by authentication plugin
    String login // we use an email address here
    String password // SHA1 hash hex
    String email // unused and not persisted
    int status // required and used by authentication plugin

    Person person
    Settings settings

    static constraints = {
        login blank:false, email:true, unique:true
        password blank:false
    }

    static transients = ['email']

    static User createSignupInstance(String loginID) {
        def p = new Person(firstGivenName:'John', familyName:'Doe')
        def s = new Settings( dateFormat:new SimpleDateFormat('yyyy-MM-dd HH:mm'), timeZone:TimeZone.default )
        return new User(login:loginID, person:p, settings:s)
    }

    def beforeInsert() { // GORM event hook
        // todo: withNewSession?
        person.save(failOnError:true) // this wasn't automatic because not all Person belongsTo User
    }
}
