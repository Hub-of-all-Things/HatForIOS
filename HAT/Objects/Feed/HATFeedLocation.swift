//
/**
 * Copyright (C) 2016-2019 Dataswift Ltd
 *
 * SPDX-License-Identifier: MPL2
 *
 * This file is part of the Hub of All Things project (HAT).
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/
 */

// MARK: Struct

public struct HATFeedLocation: HATObject {
    
    // MARK: - Coding Keys
    
    /**
     The JSON fields used by the hat
     
     The Fields are the following:
     * `address` in JSON is `address`
     * `geo` in JSON is `geo`
     */
    private enum CodingKeys: String, CodingKey {
        
        case address
        case geo
    }
    
    // MARK: - Variables

    /// The address of the location as a place with name and information on where its located. Optional
    public var address: HATFeedAddress?
    
    /// The geolocation of the location, latitude and longtitude. Optional
    public var geo: HATFeedGeo?
}
