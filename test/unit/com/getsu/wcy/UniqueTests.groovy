/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class UniqueTests extends GroovyTestCase {

    void testDuplicates() {
        def a = new Uncomparable(id:'foo')
        def b = new Uncomparable(id:'foo')
        assert a == b
        assert [a, b].unique() == [a]
    }

// http://jira.codehaus.org/browse/GROOVY-4101
//
//    void testHashCollision() {
//        def a = new Uncomparable(id:'0-42L')
//        def b = new Uncomparable(id:'0-43-')
//        assert a != b
//        assert a.hashCode() == b.hashCode()
//        assert [a, b].unique() == [a, b]
//    }
//
//    void testHashCollision2() {
//        def a = TimeZone.getTimeZone("US/Hawaii")
//        def b = TimeZone.getTimeZone("Pacific/Honolulu")
//        assert a != b
//        assert a.hashCode() == b.hashCode()
//        assert [a, b].unique() == [a, b]
//    }
}

class Uncomparable {
    String id
    boolean equals(Object that) { that && that instanceof Uncomparable && that.id == id }
    int hashCode() { id.hashCode() }
    String toString() { id }
}
