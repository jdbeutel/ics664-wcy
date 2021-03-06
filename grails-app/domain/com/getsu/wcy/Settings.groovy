/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

package com.getsu.wcy

import java.text.SimpleDateFormat

class Settings {

    SimpleDateFormat dateFormat
    TimeZone timeZone

    static belongsTo = [user:User]

    static constraints = {
    }
}
