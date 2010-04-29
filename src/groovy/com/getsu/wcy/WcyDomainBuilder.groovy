/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

import grails.util.DomainBuilder
import java.util.regex.Pattern
import groovy.util.ObjectGraphBuilder.DefaultRelationNameResolver
import org.codehaus.groovy.runtime.InvokerHelper

class WcyDomainBuilder extends DomainBuilder {
    public WcyDomainBuilder() {
        setRelationNameResolver(new WcyRelationNameResolver());
    }
}

/**
 * Impl that also handles plurals like "address" -> "addresses".
 */
class WcyRelationNameResolver extends DefaultRelationNameResolver {

    // Regular expression pattern used to identify words ending in 'y' preceded by a consonant
    private static final Pattern pluralIESPattern = Pattern.compile(".*[^aeiouy]y", Pattern.CASE_INSENSITIVE);
    private static final Pattern pluralESPattern = Pattern.compile(".*s", Pattern.CASE_INSENSITIVE);

    @Override
    public String resolveChildRelationName(String parentName, Object parent, String childName, Object child) {
        String childNamePlural = pluralize(childName)
        MetaProperty metaProperty = InvokerHelper.getMetaClass(parent).hasProperty(parent, childNamePlural);
        return metaProperty != null ? childNamePlural : childName;
    }

    private String pluralize(String s) {
        switch (s) {
            case pluralIESPattern: return s.substring(0, s.length() - 1) + 'ies'
            case pluralESPattern: return s + 'es'
            default: return s + 's'
        }
    }
}
