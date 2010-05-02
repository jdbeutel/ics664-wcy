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
}
