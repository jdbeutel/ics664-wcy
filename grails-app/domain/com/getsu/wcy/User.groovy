/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class User {

    String loginEmail
    String passwordHash
    Person person
    Settings settings

    static constraints = {
        loginEmail blank:false, email:true, unique:true
        passwordHash blank:false
    }
}
