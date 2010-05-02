/*
 * Copyright (c) 2010 J. David Beutel <software@getsu.com>
 *
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
 */
package com.getsu.wcy

class CommunicationLinks {

    static hasMany = [
            phoneNumbers:PhoneNumber,
            emailAddresses:EmailAddress,
            instantMessengerAddresses:InstantMessengerAddress,
            skypeNames:SkypeName,
            twitterNames:TwitterName,
    ]

    static void constraints(Object delegate) {
        // work-around to get errors on specific elements
        delegate.phoneNumbers validator: { it?.every { it?.validate() } }
        delegate.emailAddresses validator: { it?.every { it?.validate() } }
        delegate.instantMessengerAddresses validator: { it?.every { it?.validate() } }
        delegate.skypeNames validator: { it?.every { it?.validate() } }
        delegate.twitterNames validator: { it?.every { it?.validate() } }
    }

    static void mapping(Object delegate) {
        delegate.phoneNumbers cascade:'persist,merge,save-update' // specified because not all PhoneNumber belongsTo Person
        delegate.emailAddresses cascade:'persist,merge,save-update' // specified because not all EmailAddress belongsTo Person
        delegate.instantMessengerAddresses cascade:'persist,merge,save-update' // specified because not all InstantMessengerAddress belongsTo Person
        delegate.skypeNames cascade:'persist,merge,save-update' // specified because not all SkypeNames belongsTo Person
        delegate.twitterNames cascade:'persist,merge,save-update' // specified because not all TwitterNames belongsTo Person
    }
}
