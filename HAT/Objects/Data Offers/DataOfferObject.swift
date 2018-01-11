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

import SwiftyJSON

// MARK: Struct

public struct DataOfferObject {
    
    // MARK: - JSON Fields
    
    /// The JSON fields used by the hat
    public struct Fields {
        
        static let dataOfferID: String = "id"
        static let offerCategory: String = "category"
        static let createdDate: String = "created"
        static let offerTitle: String = "title"
        static let shortDescription: String = "shortDescription"
        static let longDescription: String = "longDescription"
        static let imageURL: String = "illustrationUrl"
        static let offerStarts: String = "starts"
        static let offerExpires: String = "expires"
        static let offerDuration: String = "collectFor"
        static let minimumUsers: String = "requiredMinUser"
        static let maximumUsers: String = "requiredMaxUser"
        static let usersClaimedOffer: String = "totalUserClaims"
        static let requiredDataDefinitions: String = "requiredDataDefinition"
        static let reward: String = "reward"
        static let owner: String = "owner"
        static let claim: String = "claim"
        static let pii: String = "pii"
        static let merchantCode: String = "merchantCode"
    }
    
    // MARK: - Variables
    
    /// The data offer ID
    public var dataOfferID: String = ""
    /// The title of the offer
    public var title: String = ""
    /// The short description of the offer
    public var shortDescription: String = ""
    /// The long description of the offer
    public var longDescription: String = ""
    /// The image URL of the offer
    public var illustrationURL: String = ""
    /// The category of the offer
    public var offerCategory: String = ""
    /// The merchant code of the offer
    public var merchantCode: String = ""
    
    /// the date created as unix time stamp
    public var created: Int = -1
    /// the start date of the offer as unix time stamp
    public var offerStarts: Int = -1
    /// the expire date of the offer as unix time stamp
    public var offerExpires: Int = -1
    /// the duration that the offer collects data for as unix time stamp
    public var collectsDataFor: Int = -1
    /// the minimum users required for the offer to activate
    public var requiredMinUsers: Int = -1
    /// the max users of the offer
    public var requiredMaxUsers: Int = -1
    /// the number of the offer claimed the offer so far
    public var usersClaimedOffer: Int = -1
    
    /// the data definition object of the offer
    public var requiredDataDefinition: [DataOfferRequiredDataDefinitionObject] = []
    
    /// the data definition v2 object of the offer
    public var requiredDataDefinitionV2: DataOfferRequiredDataDefinitionObjectV2?
    
    /// the rewards of the offer
    public var reward: DataOfferRewardsObject = DataOfferRewardsObject()
    
    /// The owner of the offer
    public var owner: DataOfferOwnerObject = DataOfferOwnerObject()
    
    /// The claim object of the offer
    public var claim: DataOfferClaimObject = DataOfferClaimObject()
    
    /// The downloaded image of the offer
    public var image: UIImage?
    
    /// Is the offer requiring pii
    public var isPΙIRequested: Bool = false
    
    // MARK: - Initialisers
    
    /**
     The default initialiser. Initialises everything to default values.
     */
    public init() {
        
        dataOfferID  = ""
        title = ""
        shortDescription = ""
        longDescription = ""
        illustrationURL = ""
        offerCategory = ""
        merchantCode = ""
        
        created = -1
        offerStarts = -1
        offerExpires = -1
        collectsDataFor = -1
        requiredMinUsers = -1
        requiredMaxUsers = -1
        usersClaimedOffer = -1
        
        requiredDataDefinition = []
        requiredDataDefinitionV2 = nil
        
        reward = DataOfferRewardsObject()
        
        owner = DataOfferOwnerObject()
        
        claim = DataOfferClaimObject()
        
        image = nil
        
        isPΙIRequested = false
    }
    
    /**
     It initialises everything from the received JSON file from the HAT
     
     - dictionary: The JSON file received
     */
    public init(dictionary: Dictionary<String, JSON>) {
        
        if let tempID = dictionary[DataOfferObject.Fields.dataOfferID]?.string {
            
            dataOfferID = tempID
        }
        
        if let tempCreated = dictionary[DataOfferObject.Fields.createdDate]?.int {
            
            created = tempCreated
        }
        
        if let tempCategory = dictionary[DataOfferObject.Fields.offerCategory]?.string {
            
            offerCategory = tempCategory
        }
        
        if let tempTitle = dictionary[DataOfferObject.Fields.offerTitle]?.string {
            
            title = tempTitle
        }
        
        if let tempShortDescription = dictionary[DataOfferObject.Fields.shortDescription]?.string {
            
            shortDescription = tempShortDescription
        }
        
        if let tempLongDescription = dictionary[DataOfferObject.Fields.longDescription]?.string {
            
            longDescription = tempLongDescription
        }
        
        if let tempIllustrationUrl = dictionary[DataOfferObject.Fields.imageURL]?.string {
            
            illustrationURL = tempIllustrationUrl
        }
        
        if let tempMerchantCode = dictionary[DataOfferObject.Fields.merchantCode]?.string {
            
            merchantCode = tempMerchantCode
        }
        
        if let tempOfferStarts = dictionary[DataOfferObject.Fields.offerStarts]?.int {
            
            offerStarts = tempOfferStarts
        }
        
        if let tempOfferExpires = dictionary[DataOfferObject.Fields.offerExpires]?.int {
            
            offerExpires = tempOfferExpires
        }
        
        if let tempCollectOfferFor = dictionary[DataOfferObject.Fields.offerDuration]?.int {
            
            collectsDataFor = tempCollectOfferFor
        }
        
        if let tempRequiresMinUsers = dictionary[DataOfferObject.Fields.minimumUsers]?.int {
            
            requiredMinUsers = tempRequiresMinUsers
        }
        
        if let tempRequiresMaxUsers = dictionary[DataOfferObject.Fields.maximumUsers]?.int {
            
            requiredMaxUsers = tempRequiresMaxUsers
        }
        
        if let tempUserClaims = dictionary[DataOfferObject.Fields.usersClaimedOffer]?.int {
            
            usersClaimedOffer = tempUserClaims
        }
        
        if let tempPII = dictionary[DataOfferObject.Fields.pii]?.bool {
            
            isPΙIRequested = tempPII
        }
        
        if let tempRequiredDataDefinition = dictionary[DataOfferObject.Fields.requiredDataDefinitions]?.array {
            
            if !tempRequiredDataDefinition.isEmpty {
                
                for dataDefination in tempRequiredDataDefinition {
                    
                    requiredDataDefinition.append(DataOfferRequiredDataDefinitionObject(dictionary: dataDefination.dictionaryValue))
                }
            }
        } else if let tempRequiredDataDefinition = dictionary[DataOfferObject.Fields.requiredDataDefinitions] {
            
            let decoder = JSONDecoder()
            do {
                
                let data = try tempRequiredDataDefinition.rawData()
                requiredDataDefinitionV2 = try decoder.decode(DataOfferRequiredDataDefinitionObjectV2.self, from: data)
            } catch {
                
                print(error)
            }
        }
        
        if let tempReward = dictionary[DataOfferObject.Fields.reward]?.dictionary {
            
            reward = DataOfferRewardsObject(dictionary: tempReward)
        }
        
        if let tempOwner = dictionary[DataOfferObject.Fields.owner]?.dictionary {
            
            owner = DataOfferOwnerObject(dictionary: tempOwner)
        }
        
        if let tempClaim = dictionary[DataOfferObject.Fields.claim]?.dictionary {
            
            claim = DataOfferClaimObject(dictionary: tempClaim)
        }
    }
    
}
