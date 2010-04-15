/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class PhoneNumber extends CommunicationLink {

    String number
    PhoneNumberType type

    static constraints = {
        number minLength:3
    }

    enum PhoneNumberType {
        LANDLINE, MOBILE, FAX
    }
}
