/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class Person {

    String preferredName
    String honorific // e.g. Mr., Dr.
    String firstGivenName
    String middleGivenNames
    String familyName // last names in English
    String suffix // e.g. Jr., III, Sr., M.D., Ph.D.

    byte[] photo
    String photoFileName // keep for format clues in the file name extension?
    Date birthDate

    List<Connection> connections // to Places

    // personal communication links (separately and statically typed for DomainBuilder at least)
    List<PhoneNumber> phoneNumbers // e.g., mobile phones
    List<EmailAddress> emailAddresses
    List<InstantMessengerAddress> instantMessengerAddresses
    List<SkypeName> skypeNames
    List<TwitterName> twitterNames
    // etc...

    String originalValuesJSON

    static transients = ['originalValuesJSON']

    static hasMany = [
            connections:Connection,
            phoneNumbers:PhoneNumber,
            emailAddresses:EmailAddress,
            instantMessengerAddresses:InstantMessengerAddress,
            skypeNames:SkypeName,
            twitterNames:TwitterName,
    ]

    static constraints = {
        preferredName nullable:true
        honorific nullable:true
        firstGivenName blank:false
        middleGivenNames nullable:true
        familyName blank:false
        suffix nullable:true
        photo nullable:true
        photoFileName nullable:true
        birthDate nullable:true
    }

    static mapping = {
        // connections handled by belongsTo = Person in Connection
        phoneNumbers cascade:'persist,merge,save-update'
        emailAddresses cascade:'persist,merge,save-update'
        instantMessengerAddresses cascade:'persist,merge,save-update'
        skypeNames cascade:'persist,merge,save-update'
        twitterNames cascade:'persist,merge,save-update'
    }

    String name // generated property, persisted for GORM sorting by <g:sortableColumn>
    String getName() { "${preferredName ?: firstGivenName} ${familyName}" }
    @Deprecated void setName(String ignored) {}
}
