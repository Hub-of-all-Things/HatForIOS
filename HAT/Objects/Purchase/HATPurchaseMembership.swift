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

// MARK: Struct

public struct HATPurchaseMembership: HATObject {
    
    // MARK: - Coding Keys
    
    /**
     The JSON fields used by the hat
     
     The Fields are the following:
     * `membershipType` in JSON is `membershipType`
     * `plan` in JSON is `plan`
     */
    private enum CodingKeys: String, CodingKey {
        
        case membershipType
        case plan
    }
    
    // MARK: - Variables

    /// Membership type
    public var membershipType: String = ""
    /// Plan
    public var plan: String = ""
}
