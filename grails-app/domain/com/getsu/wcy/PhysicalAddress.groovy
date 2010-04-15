/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class PhysicalAddress {

    String line1
    String line2
    String city
    String state // province, prefecture, etc
    String postalCode // ZIP-code
    String countryCode

    boolean postal
    boolean street // for FedEx or Google maps, not a P.O. Box

    static constraints = {
        line1 blank:false
        city blank:false
        state blank:false
    }
}
