/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

package com.getsu.wcy

import java.text.SimpleDateFormat

class Settings {

    private static VALID_TIME_ZONES = TimeZone.availableIDs.toList().grep(~/US\/.*/).collect {
        TimeZone.getTimeZone(it)
    }.unique().sort {it.rawOffset}
    static {
        def dtz = TimeZone.default
        assert VALID_TIME_ZONES.contains(dtz)
    }
    static constraints = {
        timeZone(inList:VALID_TIME_ZONES)
        foo(inList:['a','b','c'])
    }

    SimpleDateFormat dateFormat
    TimeZone timeZone
    String foo
}
