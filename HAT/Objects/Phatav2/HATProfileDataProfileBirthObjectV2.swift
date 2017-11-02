//
//  HATProfileDataProfileBirthObjectV2.swift
//  HAT
//
//  Created by Marios-Andreas Tsekis on 2/11/17.
//  Copyright © 2017 HATDeX. All rights reserved.
//

import UIKit

public struct HATProfileDataProfileBirthObjectV2: Codable, HATObject {

    // MARK: - Variables
    
    /// Indicates if the object, HATProfileDataProfileBirthObject, is private
    public var `private`: Bool = true
    
    /// User's date of birth
    public var date: String = ""
}
