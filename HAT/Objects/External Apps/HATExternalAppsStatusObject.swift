//
/**
 * Copyright (C) 2018 HAT Data Exchange Ltd
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

public struct HATExternalAppsStatusObject: HATObject {
    
    // MARK: - Variables
    
    /// The compatibility of this app
    public var compatibility: String = ""
    /// The endpoing this app will be reading or writing on HAT
    public var recentDataCheckEndpoint: String = ""
    /// The kind of the app
    public var kind: String = ""
    public var statusUrl: String?
    public var expectedStatus: Int?
    public var dataPreviewEndpoint: String?
}
