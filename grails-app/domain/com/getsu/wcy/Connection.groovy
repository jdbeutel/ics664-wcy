/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class Connection {

    Place place
    ConnectionType type

    // this Person's communication links for this place
    List<PhoneNumber> phoneNumbers // e.g., office phone/extension
    List<EmailAddress> emailAddresses // e.g., work email
    List<InstantMessengerAddress> instantMessengerAddresses
    List<SkypeName> skypeNames
    List<TwitterName> twitterNames
    // etc...

    static belongsTo = Person
    static hasMany = CommunicationLinks.hasMany
    static transients = ['preferredPhone', 'preferredAddress', 'preferredEmail']

    static constraints = {
        place validator: { it?.validate() }  // work-around to deepValidate for cascade
        CommunicationLinks.constraints(delegate)
    }

    static mapping = {
        place cascade:'persist,merge,save-update' // specified because Place does not belongsTo one Connection
        CommunicationLinks.mapping(delegate)
    }

    enum ConnectionType {
        HOME, WORK
    }

    def getPreferredEmail() {
        // todo: user preferences for selection
        if (emailAddresses[0]) { // todo: no [0]?
            return [type:'DIRECT', address:emailAddresses[0].address]
        } else if (place.emailAddresses) {
            return [type:'', address:place.emailAddresses[0].address]
        } else {
            return null
        }
    }

    def getPreferredPhone() {
        // todo: user preferences and smarter selection by PhoneNumberType
        if (phoneNumbers[0]) {
            return [type:phoneNumbers[0].type, number:phoneNumbers[0].number]
        } else if (place.phoneNumbers) {
            return [type:"${place.phoneNumbers[0].type}", number:place.phoneNumbers[0].number]
        } else {
            return null
        }
    }

    Address getPreferredAddress() {
        // todo: user preferences and smarter selection by streetType/postalType
        return place?.addresses[0]
    }
}
