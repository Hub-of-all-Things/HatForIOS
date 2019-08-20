//
/**
 * Copyright (C) 2019 HAT Data Exchange Ltd
 *
 * SPDX-License-Identifier: MPL2
 *
 * This file is part of the Hub of All Things project (HAT).
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/
 */

/// MARK: Struct

public struct HATSpotifyProfileImages: HATObject {
    
    // MARK: - Coding Keys
    
    /**
     The JSON fields used by the hat
     
     The Fields are the following:
     * `url` in JSON is `url`
     */
    private enum CodingKeys: String, CodingKey {
        
        case url
    }
    
    // MARK: - Variables

    /// The url of the image in order to fetch it
    public var url: String = ""
}
