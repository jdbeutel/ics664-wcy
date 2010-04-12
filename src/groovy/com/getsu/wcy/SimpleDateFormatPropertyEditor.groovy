/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

import java.beans.PropertyEditorSupport
import java.text.SimpleDateFormat

class SimpleDateFormatPropertyEditor extends PropertyEditorSupport {

    void setAsText(String pattern) {
        setValue(new SimpleDateFormat(pattern))
    }

    String getAsText() {
        Object value = getValue()
        if (value instanceof SimpleDateFormat) {
            return ((SimpleDateFormat)value).toPattern()
        }
        else {
            return String.valueOf(value)
        }
    }
}
