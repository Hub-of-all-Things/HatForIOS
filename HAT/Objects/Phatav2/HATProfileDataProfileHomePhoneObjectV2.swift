//
//  HATProfileDataProfileHomePhoneObjectV2.swift
//  HAT
//
//  Created by Marios-Andreas Tsekis on 2/11/17.
//  Copyright © 2017 HATDeX. All rights reserved.
//

import UIKit

public struct HATProfileDataProfileHomePhoneObjectV2: Codable, HATObject {

    // MARK: - Variables
    
    /// Indicates if the object, HATProfileDataProfileHomePhoneObject, is private
    public var `private`: Bool = true
    
    /// User's home phone number
    public var no: String = ""
}
