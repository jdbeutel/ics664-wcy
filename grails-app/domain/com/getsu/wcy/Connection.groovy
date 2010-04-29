/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class Connection {

    Place place
    ConnectionType type
    static belongsTo = Person
    static hasMany = [comLinks:CommunicationLink /* e.g., work phone number or email */]

    static constraints = {
    }

    static mapping = {
        place cascade:'persist,merge,save-update'
    }

    enum ConnectionType {
        HOME, WORK
    }
}
