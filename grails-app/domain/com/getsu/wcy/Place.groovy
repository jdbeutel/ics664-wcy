/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

/**
 * A single location, such as an apartment or office.
 */
class Place {

    List<Address> addresses
    // communication links for this whole Place (not specific to any Person)
    List<PhoneNumber> phoneNumbers // e.g., a home's land-line, an office's reception desk, etc
    List<EmailAddress> emailAddresses // e.g., an office's support or sales alias
    List<InstantMessengerAddress> instantMessengerAddresses // some of these types may not be applicable...
    List<SkypeName> skypeNames
    List<TwitterName> twitterNames
    // etc...

    static hasMany = [
            addresses:Address, // may be unknown, or separate postalType and streetType addresses
            phoneNumbers:PhoneNumber,
            emailAddresses:EmailAddress,
            instantMessengerAddresses:InstantMessengerAddress,
            skypeNames:SkypeName,
            twitterNames:TwitterName,
    ]

    static constraints = {
    }

    static mapping = {
        // addresses handled by belongsTo = Place in Address
        phoneNumbers cascade:'persist,merge,save-update'
        emailAddresses cascade:'persist,merge,save-update'
        instantMessengerAddresses cascade:'persist,merge,save-update'
        skypeNames cascade:'persist,merge,save-update'
        twitterNames cascade:'persist,merge,save-update'
    }
}
