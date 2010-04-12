/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

import org.springframework.beans.PropertyEditorRegistrar
import org.springframework.beans.PropertyEditorRegistry
import java.text.SimpleDateFormat

class CustomPropertyEditorRegistrar implements PropertyEditorRegistrar {
    void registerCustomEditors(PropertyEditorRegistry r) {
        r.registerCustomEditor(SimpleDateFormat, new SimpleDateFormatPropertyEditor())
    }
}
