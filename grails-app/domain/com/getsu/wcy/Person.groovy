/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class Person {

    String preferredName
    String familyName // last names in English
    String givenNames // first and middle names in English
    String honorific // e.g. Mr., Dr.
    String suffix // e.g. Jr., III, Sr., M.D., Ph.D.

    File photo
    Date birthDate

    static hasMany = [comLinks:CommunicationLink /* e.g. mobile phone or IM */, places:Connection]

    static constraints = {
        familyName blank:false
        givenNames blank:false
    }
}
