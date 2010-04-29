/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */

package com.getsu.wcy

import java.text.SimpleDateFormat

class WcyTagLib {

    static namespace='wcy'

    def authenticationService

    private static VALID_TIME_ZONES = TimeZone.availableIDs.toList().grep(~/US\/.*/).collect { String id ->
        TimeZone.getTimeZone(id)
    }.unique().sort {it.rawOffset}
// sometimes this prevents start-up
//    static {
//        def dtz = TimeZone.default
//        assert VALID_TIME_ZONES.contains(dtz)
//    }

    /**
     *  A timeZoneSelect tag with limited options.
     * eg. <wcy:timeZoneSelect name="myTimeZone" value="${tz}" />
     */
    def timeZoneSelect = {attrs ->
        attrs['from'] = VALID_TIME_ZONES.ID
        attrs['value'] = (attrs['value'] ? attrs['value'].ID : TimeZone.getDefault().ID)

        // set the option value as a closure that formats the TimeZone for display
        attrs['optionValue'] = { formatTimeZone(TimeZone.getTimeZone(it)) }

        // use generic select
        out << g.select(attrs)
    }

    def formatTimeZone = {TimeZone tz ->
        def now = new Date()
        def shortName = tz.getDisplayName(tz.inDaylightTime(now), TimeZone.SHORT)
        def longName = tz.getDisplayName(tz.inDaylightTime(now), TimeZone.LONG)

        def offset = tz.rawOffset
        int hour = offset / (60 * 60 * 1000)
        String min = String.valueOf((int) Math.abs(offset / (60 * 1000)) % 60).padRight(2, '0')

        return "${shortName} (${tz.ID}), ${longName} ${hour}:${min}"
    }

    private static VALID_DATE_FORMATS = [
            'MM/dd/yyyy h:mm a',
            'yyyy-MM-dd HH:mm',
            'yyyy-MM-dd HH:mm z',
            'MMM d, yyyy h:mm a',
            'EEE, MMM d, yyyy h:mm a',
            'EEE, d MMM yyyy h:mm a',
            'EEE, d MMM yyyy HH:mm',
            'EEE, d MMM yyyy HH:mm z'
    ]

    /**
     *  A dateFormatSelect tag.
     * eg. <wcy:timeZoneSelect name="myTimeZone" value="${tz}" />
     */
    def dateFormatSelect = {attrs ->
        attrs['from'] = VALID_DATE_FORMATS
        if (!attrs['value'] instanceof SimpleDateFormat) {
            throw new IllegalArgumentException("value must be a SimpleDateFormat: ${attrs['value']}")
        }
        attrs['value'] = (attrs['value']?.toPattern() ?: VALID_DATE_FORMATS[0])

        // set the option value as a closure that formats the DateFormat for display
        attrs['optionValue'] = { formatDateFormat(new SimpleDateFormat(it)) }

        // use generic select
        out << g.select(attrs)
    }

    def formatDateFormat = {SimpleDateFormat df ->
        def now = new Date()
        df.format(now)
    }

    def required = {out << '*'}
    def requiredLegend = {out << '<div class="requiredLegend">* required fields</div>'}

    def formatDate = {attrs ->
        User u = authenticationService.userPrincipal
        String format = u?.settings?.dateFormat?.toPattern()
        attrs['format'] = format ?: attrs['format']
        out << g.formatDate(attrs)
    }
}
