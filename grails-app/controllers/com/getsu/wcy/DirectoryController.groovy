/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class DirectoryController {

    static navigation = [group:'tabs', order:50, title:'directory']

    def index = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        // todo: access controls
        [personInstanceList: Person.list(params), personInstanceTotal: Person.count()]
    }
}
