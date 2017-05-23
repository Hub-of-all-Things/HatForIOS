/**
 * Copyright (C) 2017 HAT Data Exchange Ltd
 *
 * SPDX-License-Identifier: MPL2
 *
 * This file is part of the Hub of All Things project (HAT).
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/
 */

import SwiftyJSON

public class HATNationalityObject: Comparable {
    
    // MARK: - Comparable protocol
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: HATNationalityObject, rhs: HATNationalityObject) -> Bool {
        
        return (lhs.nationality == rhs.nationality && lhs.passportNumber == rhs.passportNumber)
    }
    
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func <(lhs: HATNationalityObject, rhs: HATNationalityObject) -> Bool {
        
        return lhs.nationality < rhs.nationality
    }
    
    // MARK: - Variables
    
    /// Indicates if the object, HATProfileDataProfilePrimaryEmailObject, is private
    public var nationality: String = ""
    public var passportHeld: String = ""
    public var passportNumber: String = ""
    public var placeOfBirth: String = ""
    public var language: String = ""
    public var recordID: String = ""
    public var unixTimeStamp: Int? = Int(HATFormatterHelper.formatDateToISO(date: Date()))
    
    // MARK: - Initialisers
    
    /**
     The default initialiser. Initialises everything to default values.
     */
    public init() {
        
        nationality = ""
        passportHeld = ""
        passportNumber = ""
        placeOfBirth = ""
        language = ""
        recordID = ""
        unixTimeStamp = Int(HATFormatterHelper.formatDateToISO(date: Date()))
    }
    
    /**
     It initialises everything from the received JSON file from the HAT
     */
    public init(from dict: JSON) {
        
        if let data = (dict["data"].dictionary) {
            
            nationality = (data["nationality"]!.stringValue)
            passportHeld = (data["passportHeld"]!.stringValue)
            passportNumber = (data["passportNumber"]!.stringValue)
            placeOfBirth = (data["placeOfBirth"]!.stringValue)
            language = (data["language"]!.stringValue)
            unixTimeStamp = Int((data["unixTimeStamp"]!.stringValue))
        }
        
        recordID = (dict["recordId"].stringValue)
    }
    
    public func toJSON() -> Dictionary<String, String> {
        
        return [
        
            "nationality" : self.nationality,
            "passportHeld" : self.passportHeld,
            "passportNumber" : self.passportNumber,
            "placeOfBirth" : self.placeOfBirth,
            "language" : self.language
        ]
        
    }

}
