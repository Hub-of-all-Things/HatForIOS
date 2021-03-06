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

import Alamofire
import Mockingjay
import SwiftyJSON
import XCTest

internal class SpotifyServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetSpotifyProfile() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let body: [Dictionary<String, Any>] = [
            [
                "endpoint": "spotify/profile",
                "recordId": "f277374c-df57-410c-aa07-d448eb9354da",
                "data": [
                    "id": "21vteht26stx2pltn3bdodrqi",
                    "uri": "spotify:user:21vteht26stx2pltn3bdodrqi",
                    "href": "https://api.spotify.com/v1/users/21vteht26stx2pltn3bdodrqi",
                    "type": "user",
                    "email": "liz_chandler@yahoo.com",
                    "images": [
                        [
                            "url": "https://lookaside.facebook.com/platform/profilepic/?asid=111929542992117&height=200&width=200&ext=1523211989&hash=AeTs-b5cXSPu5Tuy"
                        ]
                    ],
                    "country": "LT",
                    "product": "open",
                    "birthdate": "1998-01-18",
                    "followers": [
                        "href": "",
                        "total": 0
                    ],
                    "dateCreated": "2018-04-09T06:18:56.208Z",
                    "display_name": "Liz Chandler",
                    "external_urls": [
                        "spotify": "https://open.spotify.com/user/21vteht26stx2pltn3bdodrqi"
                    ]
                ]
            ]
        ]
        let userDomain: String = "testing.hubat.net"
        let urlToConnect: String = "https://testing.hubat.net/api/v2.6/data/spotify/profile?orderBy=dateCreated&ordering=descending&take=1"
        let token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJleUp3Y205MmFXUmxja2xFSWpvaWJXRnlhVzl6ZEhObGEybHpMbWgxWW05bVlXeHNkR2hwYm1kekxtNWxkQ0lzSW5CeWIzWnBaR1Z5UzJWNUlqb2liV0Z5YVc5emRITmxhMmx6SW4wPSIsInJlc291cmNlIjoibWFyaW9zdHNla2lzLmh1Ym9mYWxsdGhpbmdzLm5ldCIsImFjY2Vzc1Njb3BlIjoib3duZXIiLCJpc3MiOiJtYXJpb3N0c2VraXMuaHVib2ZhbGx0aGluZ3MubmV0IiwiZXhwIjoxNDg3MzIyNzk0LCJpYXQiOjE0ODcwNjM1OTQsImp0aSI6ImUxYWY1ODY3ZWRhNjFmM2MxMmE3YzE1OGEwNDhmMjM0YmFiMzI3ZDVhNzQ5NDIzYWIwNGU1OTkxZTUxZDE1MTM0MzE3MDQwZDFhMjBiNTI1ZDMxODFmNWJiNTI3ZmVkMWJhMWYzZWEwZTlmZTM0MjZmM2E5ZDMwNmFjMGY3NGFjMTM1MWQ1OTFhYmMxZTI4NmJmMGYyMjgzNzRkZWU2MDdhYWQ2MjU3OGJkNzJhZTI2OWI4NDY4NWJiYjY2OGMzMmQzODRkZjQwZjIxNDU4Y2IwMjFlMDc5ODc5MzFmNmVlNTMyNWMxNGViNGNiOGFmYTNlMWI0ZjgwNzQ5M2M3ZDYifQ.lz3Snzglz9WtGTIlp4qmJsCnpljrwafYRSg7QKa9CNQAfq_yB5XIOcfH8As8f_fneQW08-ats4Qk1F_yfeQKPIa2GnissQj0W2rl4pnRMiFcKE2vddMRsM_fwGEsr43foGNIjJM3KIBPaECxC_QZdGdqu_wnpSS2rRqbJPrcdPs5FOhAWaLdL6ej0vkhdVX97-VwGyW70AcwZ-yFP8mKLZygwixqPn1-ubCc2ahkS94cM40s4-fon0HNNC4SNOB-q4g_87caAjXRN6cchrJitltHZ3_4xe4p9wMCK-LGjF99xUYT4aUbsiJ4tOPKOcqQsZgbfBZGqUM4_4aHQQ3Pxg"
        
        let expectationTest: XCTestExpectation = expectation(description: "Fetching spotify profile...")
        
        MockingjayProtocol.addStub(matcher: http(.get, uri: urlToConnect), builder: json(body))
        
        func completion(profile: [HATSpotifyProfile], newToken: String?) {
            
            XCTAssertTrue(!profile.isEmpty)
            expectationTest.fulfill()
        }
        
        func failed(error: HATTableError) {
          
            XCTFail()
            expectationTest.fulfill()
        }
        
        HATSpotifyService.getSpotifyProfile(
            userToken: token,
            userDomain: userDomain,
            successCallback: completion,
            errorCallback: failed)
        
        waitForExpectations(timeout: 10) { error in
            
            if let error: Error = error {
                
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
