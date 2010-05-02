/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

import com.getsu.wcy.Connection.ConnectionType

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

    static transients = ['originalValuesJSON', 'preferredPhone', 'preferredConnection', 'preferredEmail']

    static hasMany = CommunicationLinks.hasMany + [
            connections:Connection,
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

        // Connection's belongsTo = Person handles validation, but generating errors one level too high, so
        connections validator: { it?.every { it?.validate() } }  // work-around to get errors on specific connections

        CommunicationLinks.constraints(delegate)
    }

    static mapping = {
        sort name:'asc'
        // connections handled by belongsTo = Person in Connection
        CommunicationLinks.mapping(delegate)
    }

    // generated property, persisted for GORM sorting by <g:sortableColumn>
    @Deprecated void setName(String ignored) {}
    String getName() { "${preferredName ?: firstGivenName} ${familyName}" }

    // I doubt GORM can persist this (for sortableColumn), because updates of associates
    // would need to cascade up to trigger updates of Person.
    def getPreferredEmail() {
        // todo: user preferences and smarter selection by ConnectionType
        def connectionWithEmail = connections.find {it.emailAddresses}
        def connectionWithPlaceEmail = connections.find {it.place.emailAddresses}
        if (emailAddresses[0]) {
            return [type:'PERSONAL', address:emailAddresses[0].address]
        } else if (connectionWithEmail) {
            def c = connectionWithEmail
            return [type:"$c.type", address:c.emailAddresses[0].address]
        } else if (connectionWithPlaceEmail) {
            def c = connectionWithPlaceEmail
            return [type:"$c.type", address:c.place.emailAddresses[0].address]
        } else {
            return null
        }
    }

    // I doubt GORM can persist this (for sortableColumn), because updates of associates
    // would need to cascade up to trigger updates of Person.
    def getPreferredPhone() {
        // todo: user preferences and smarter selection by PhoneNumberType and ConnectionType
        def connectionWithPhoneNumber = connections.find {it.phoneNumbers}
        def connectionWithPlacePhoneNumber = connections.find {it.place.phoneNumbers}
        if (phoneNumbers[0]) {
            return [type:phoneNumbers[0].type, number:phoneNumbers[0].number]
        } else if (connectionWithPhoneNumber) {
            def c = connectionWithPhoneNumber
            return [type:"$c.type ${c.phoneNumbers[0].type}", number:c.phoneNumbers[0].number]
        } else if (connectionWithPlacePhoneNumber) {
            def c = connectionWithPlacePhoneNumber
            return [type:"$c.type ${c.place.phoneNumbers[0].type}", number:c.place.phoneNumbers[0].number]
        } else {
            return null
        }
    }

    // I doubt GORM can persist this (for sortableColumn), because updates of associates
    // would need to cascade up to trigger updates of Person.
    Connection getPreferredConnection() {
        // todo: user preferences and smarter selection by ConnectionType and streetType/postalType
        def home = connections.find {it.type == ConnectionType.HOME && it.place?.addresses}
        def work = connections.find {it.type == ConnectionType.WORK && it.place?.addresses}
        return home ?: work
    }
}
