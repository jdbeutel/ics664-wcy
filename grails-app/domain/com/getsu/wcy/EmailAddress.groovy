/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class EmailAddress extends CommunicationLink {

    String name
    String address

    static constraints = {
        address email:true
    }
}
