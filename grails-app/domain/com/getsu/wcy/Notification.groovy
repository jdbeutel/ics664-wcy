/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class Notification {

    User recipient
    Date date
    User subject
    String verb // Grails is already using "action"
    Person object // todo: Data superclass?
    // todo: static hasMany = [actions:History] details

    static constraints = {
        verb blank:false
    }

    static mapping = {
        sort date:'desc' // most recently first
    }
}
