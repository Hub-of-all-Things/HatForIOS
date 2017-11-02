//
//  HATProfileDataProfileAlternativeEmailObjectV2.swift
//  HAT
//
//  Created by Marios-Andreas Tsekis on 2/11/17.
//  Copyright © 2017 HATDeX. All rights reserved.
//

import UIKit

public struct HATProfileDataProfileAlternativeEmailObjectV2: Codable, HATObject {

    // MARK: - Variables
    
    /// Indicates if the object, HATProfileDataProfileAlternativeEmailObject, is private
    public var `private`: Bool = true
    
    /// The user's alternative email address
    public var value: String = ""
}
