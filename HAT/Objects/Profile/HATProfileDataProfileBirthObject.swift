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

// MARK: Struct

/// A struct representing the profile data Birth object from the received profile JSON file
public struct HATProfileDataProfileBirthObject: Comparable {
    
    // MARK: - Comparable protocol
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: HATProfileDataProfileBirthObject, rhs: HATProfileDataProfileBirthObject) -> Bool {
        
        return (lhs.isPrivate == rhs.isPrivate && lhs.date == rhs.date)
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
    public static func <(lhs: HATProfileDataProfileBirthObject, rhs: HATProfileDataProfileBirthObject) -> Bool {
        
        if lhs.date != nil && rhs.date != nil {
            
            return lhs.date! < rhs.date!
        }
        
        return false
    }
    
    // MARK: - Variables

    /// Indicates if the object, HATProfileDataProfileBirthObject, is private
    public var isPrivate: Bool = true {
        
        didSet {
            
            isPrivateTuple = (isPrivate, isPrivateTuple.1)
        }
    }
    
    /// User's date of birth
    public var date: Date? = nil {
        
        didSet {
            
            dateTuple = (date, dateTuple.1)
        }
    }
    
    /// A tuple containing the isPrivate and the ID of the value
    var isPrivateTuple: (Bool, Int) = (true, 0)
    
    /// A tuple containing the value and the ID of the value
    var dateTuple: (Date?, Int) = (nil, 0)
    
    // MARK: - Initialisers
    
    /**
     The default initialiser. Initialises everything to default values.
     */
    public init() {
        
        isPrivate = true
        date = nil
        
        isPrivateTuple = (true, 0)
        dateTuple = (nil, 0)
    }
    
    /**
     It initialises everything from the received JSON file from the HAT
     */
    public init(from array: [JSON]) {
        
        for json in array {
            
            let dict = json.dictionaryValue
            
            if let tempName = (dict["name"]?.stringValue) {
                
                if tempName == "private" {
                    
                    if let tempValues = dict["values"]?.arrayValue {
                        
                        isPrivate = Bool((tempValues[0].dictionaryValue["value"]?.stringValue)!)!
                        isPrivateTuple = (isPrivate, (dict["id"]?.intValue)!)
                    }
                }
                
                if tempName == "date" {
                    
                    if let tempValues = dict["values"]?.arrayValue {
                        
                        let tempDate = (tempValues[0].dictionaryValue["value"]?.stringValue)!
                        date = HATFormatterHelper.formatStringToDate(string: String(tempDate))
                        dateTuple = (date, (dict["id"]?.intValue)!)
                    }
                }
            }
        }
    }
    
    /**
     It initialises everything from the received JSON file from the HAT
     */
    public init(alternativeArray: [JSON]) {
        
        for json in alternativeArray {
            
            let dict = json.dictionaryValue
            
            if let tempName = (dict["name"]?.stringValue) {
                
                if tempName == "private" {
                    
                    isPrivate = true
                    isPrivateTuple = (isPrivate, (dict["id"]?.intValue)!)
                }
                
                if tempName == "date" {
                    
                    date = HATFormatterHelper.formatStringToDate(string: String(describing: Date()))
                    dateTuple = (date, (dict["id"]?.intValue)!)
                }
            }
        }
    }
    
}