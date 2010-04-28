/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

import java.text.SimpleDateFormat
import com.getsu.wcy.Connection.ConnectionType

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
        // The authentication plugin saves the User before we can save its Person and Settings,
        // so start with these temporary values to satisfy constraints.
        def address = new PhysicalAddress(city:'during signup', state:'HI', streetType:true)
        def home = new Place().addToAddresses(address)
        def connection = new Connection(place:home, type:ConnectionType.HOME)
        def p = new Person(firstGivenName:'during signup', familyName:'during signup')
        def s = new Settings( dateFormat:new SimpleDateFormat('yyyy-MM-dd HH:mm'), timeZone:TimeZone.default )
        def u = new User(login:loginID, person:p, settings:s)
        u.person.addToConnections(connection)
        return u
    }

    def beforeInsert() { // GORM event hook
        // todo: withNewSession?
        // todo: mapping cascades instead?
        // GORM doesn't automatically because a Place may be in more than one Connection
        person.connections.each { it.place.save(failOnError:true) }
        // GORM doesn't automatically because not all Person belongsTo User
        person.save(failOnError:true)
    }
}
