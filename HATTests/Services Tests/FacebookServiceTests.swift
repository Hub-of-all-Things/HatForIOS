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

internal class FacebookServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetFacebookProfileImage() {
        
        let body: [Dictionary<String, Any>] = [[
            "endpoint": "facebook/profile/picture",
            "recordId": "c7e2b5eb-87c8-4dfd-b304-5d47cd6e97c5",
            "data": [
                "url": "https://scontent.xx.fbcdn.net/v/t1.0-1/p320x320/22050067_10214414562536185_3335565455711428906_n.jpg?oh=1f8957baf78066ad7a9b0e9eaaf1f024&oe=5A98FE74",
                "width": 320,
                "height": 320,
                "is_silhouette": false
            ]
        ]]
        let userDomain: String = "mariostsekis.hubat.net"
        let urlToConnect: String = "https://mariostsekis.hubat.net/api/v2.6/data/facebook/profile/picture"
        
        let expectationTest: XCTestExpectation = expectation(description: "Checking facebook profile image info...")
        
        MockingjayProtocol.addStub(matcher: http(.get, uri: urlToConnect), builder: json(body))
        
        func completion(profileImages: [HATFacebookProfileImage], newToken: String?) {
            
            XCTAssertTrue(!profileImages.isEmpty)
            expectationTest.fulfill()
        }
        
        func failed(error: HATTableError) {
            
            XCTFail()
            expectationTest.fulfill()
        }
        
        HATFacebookService.fetchProfileFacebookPhoto(authToken: "", userDomain: userDomain, parameters: [:], successCallback: completion, errorCallback: failed)
        
        waitForExpectations(timeout: 10) { error in
            
            if let error: Error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testGetFacebookData() {
        
        let body: [Dictionary<String, Any>] = [[
            "endpoint": "facebook/feed",
            "recordId": "44f8461f-52e2-4953-9146-2b6f72724d7b",
            "data": [
                "id": "10208242138349438_10215582474533255",
                "from": [
                    "id": "10208242138349438",
                    "name": "Andrius Aucinas"
                ],
                "type": "status",
                "place": [
                    "id": "773512479404143",
                    "name": "Vilnius Airport",
                    "location": [
                        "zip": "02189",
                        "city": "Vilnius",
                        "street": "Rodūnios kelias 2",
                        "country": "Lithuania",
                        "latitude": 54.6428795,
                        "longitude": 25.2795944
                    ]
                ],
                "story": "Andrius Aucinas checked in to Vilnius Airport.",
                "message": "‘tis going to be one loooong day...",
                "privacy": [
                    "deny": "2461771541953",
                    "allow": "",
                    "value": "CUSTOM",
                    "friends": "ALL_FRIENDS",
                    "description": "Friends"
                ],
                "is_hidden": false,
                "status_type": "mobile_status_update",
                "created_time": "2018-02-08T00:53:19+0000",
                "is_published": true,
                "updated_time": "2018-02-08T00:53:19+0000"
            ]
        ]]
        let userDomain: String = "mariostsekis.hubat.net"
        let urlToConnect: String = "https://mariostsekis.hubat.net/api/v2.6/data/facebook/feed"
        
        let expectationTest: XCTestExpectation = expectation(description: "Getting facebook data from hat...")
        
        MockingjayProtocol.addStub(matcher: http(.get, uri: urlToConnect), builder: json(body))
        
        func completion(feed: [HATFacebook], newToken: String?) {
            
            XCTAssertTrue(!feed.isEmpty)
            expectationTest.fulfill()
        }
        
        func failed(error: HATTableError) {
            
            XCTFail()
            expectationTest.fulfill()
        }
        
        HATFacebookService.getFacebookData(authToken: "", userDomain: userDomain, parameters: [:], successCallback: completion, errorCallback: failed)
        
        waitForExpectations(timeout: 10) { error in
            
            if let error: Error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func testGettingFacebookToken() {
        
        let body: Dictionary<String, Any> = ["accessToken": "token"]
        let userDomain: String = "mariostsekis.hubofallthings.net"
        let urlToConnect: String = "https://\(userDomain)/users/application_token?name=facebook&resource=facebook"
        
        let expectationTest: XCTestExpectation = expectation(description: "Getting app token for facebook...")
        
        MockingjayProtocol.addStub(matcher: everything, builder: json(body))
        
        func completion(facebookToken: String, newUserToken: String?) {
            
            XCTAssertTrue(facebookToken == "token")
            expectationTest.fulfill()
        }
        
        func failed(error: JSONParsingError) {
            
            XCTFail()
            expectationTest.fulfill()
        }
        
        var plug: HATDataPlug = HATDataPlug()
        plug.information.name = "facebook"
        plug.information.url = "facebook"
        
        HATFacebookService.getAppTokenForFacebook(plug: plug, token: "", userDomain: userDomain, successful: completion, failed: failed)
        
        waitForExpectations(timeout: 10) { error in
            
            if let error: Error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testIsFacebookDataPlugActive() {

        let body: Dictionary<String, Any> = ["canPost": "true"]
        let userDomain: String = "mariostsekis.hubofallthings.net"
        let urlToConnect: String = "https://facebook.hubofallthings.com/api/status"
        let token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJleUp3Y205MmFXUmxja2xFSWpvaWJXRnlhVzl6ZEhObGEybHpMbWgxWW05bVlXeHNkR2hwYm1kekxtNWxkQ0lzSW5CeWIzWnBaR1Z5UzJWNUlqb2liV0Z5YVc5emRITmxhMmx6SW4wPSIsInJlc291cmNlIjoibWFyaW9zdHNla2lzLmh1Ym9mYWxsdGhpbmdzLm5ldCIsImFjY2Vzc1Njb3BlIjoib3duZXIiLCJpc3MiOiJtYXJpb3N0c2VraXMuaHVib2ZhbGx0aGluZ3MubmV0IiwiZXhwIjoxNDg3MzIyNzk0LCJpYXQiOjE0ODcwNjM1OTQsImp0aSI6ImUxYWY1ODY3ZWRhNjFmM2MxMmE3YzE1OGEwNDhmMjM0YmFiMzI3ZDVhNzQ5NDIzYWIwNGU1OTkxZTUxZDE1MTM0MzE3MDQwZDFhMjBiNTI1ZDMxODFmNWJiNTI3ZmVkMWJhMWYzZWEwZTlmZTM0MjZmM2E5ZDMwNmFjMGY3NGFjMTM1MWQ1OTFhYmMxZTI4NmJmMGYyMjgzNzRkZWU2MDdhYWQ2MjU3OGJkNzJhZTI2OWI4NDY4NWJiYjY2OGMzMmQzODRkZjQwZjIxNDU4Y2IwMjFlMDc5ODc5MzFmNmVlNTMyNWMxNGViNGNiOGFmYTNlMWI0ZjgwNzQ5M2M3ZDYifQ.lz3Snzglz9WtGTIlp4qmJsCnpljrwafYRSg7QKa9CNQAfq_yB5XIOcfH8As8f_fneQW08-ats4Qk1F_yfeQKPIa2GnissQj0W2rl4pnRMiFcKE2vddMRsM_fwGEsr43foGNIjJM3KIBPaECxC_QZdGdqu_wnpSS2rRqbJPrcdPs5FOhAWaLdL6ej0vkhdVX97-VwGyW70AcwZ-yFP8mKLZygwixqPn1-ubCc2ahkS94cM40s4-fon0HNNC4SNOB-q4g_87caAjXRN6cchrJitltHZ3_4xe4p9wMCK-LGjF99xUYT4aUbsiJ4tOPKOcqQsZgbfBZGqUM4_4aHQQ3Pxg"

        let expectationTest: XCTestExpectation = expectation(description: "Checking facebook hat...")

        MockingjayProtocol.addStub(matcher: http(.get, uri: urlToConnect), builder: json(body))

        func completion(result: Bool) {

            XCTAssertTrue(result)
            expectationTest.fulfill()
        }

        func failed(error: DataPlugError) {

            XCTFail()
            expectationTest.fulfill()
        }

        HATFacebookService.isFacebookDataPlugActive(appToken: token, url: urlToConnect, successful: completion, failed: failed)

        waitForExpectations(timeout: 10) { error in

            if let error: Error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func testRemoveDuplicatesFromObjects() {

        let obj1: HATFacebook = HATFacebook()
        let obj2: HATFacebook = HATFacebook()

        var array: [HATFacebook] = [obj1, obj2]

        array = HATFacebookService.removeDuplicatesFrom(array: array)

        XCTAssertTrue(array.count == 1)
    }

    func testRemoveDuplicatesFromJSON() {

        let obj1: JSON = [
            "name": "default_Sun Jan 08 2017 21:21:26 GMT+0000 (UTC)",
            "data": [
                "posts": [
                    "id": "10208854387451137_10209321243402244",
                    "created_time": "2017-01-08T20:31:59+0000",
                    "full_picture": "https://scontent.xx.fbcdn.net/v/t1.0-9/s720x720/15894983_10209321242442220_342243781888644727_n.jpg?oh=b90d598e80b1386cd92eb29b63990384&oe=58DA38A3",
                    "link": "https://www.facebook.com/photo.php?fbid=10209321242442220&set=a.1908663150443.2108294.1057751927&type=3",
                    "from": [
                        "id": "10208854387451137",
                        "name": "Marios Tsekis"
                    ],
                    "picture": "https://scontent.xx.fbcdn.net/v/t1.0-0/s130x130/15894983_10209321242442220_342243781888644727_n.jpg?oh=80d63b5741590e1c22cb74fc9f07db47&oe=58E779B6",
                    "type": "photo",
                    "updated_time": "2017-01-08T20:31:59+0000",
                    "status_type": "added_photos",
                    "story": "Marios Tsekis added 2 new photos — with Lia Tseki and 6 others at Little Archies Reichenbach.",
                    "object_id": "10209321242442220",
                    "privacy": [
                        "friends": "",
                        "value": "ALL_FRIENDS",
                        "deny": "",
                        "description": "Your friends",
                        "allow": ""
                    ],
                    "name": "Photos from Marios Tsekis's post"
                ]
            ],
            "id": 7771,
            "lastUpdated": "2017-01-08T21:21:26.184Z"
        ]
        let obj2: JSON = [
            "name": "default_Sun Jan 08 2017 21:21:26 GMT+0000 (UTC)",
            "data": [
                "posts": [
                    "id": "10208854387451137_10209321243402244",
                    "created_time": "2017-01-08T20:31:59+0000",
                    "full_picture": "https://scontent.xx.fbcdn.net/v/t1.0-9/s720x720/15894983_10209321242442220_342243781888644727_n.jpg?oh=b90d598e80b1386cd92eb29b63990384&oe=58DA38A3",
                    "link": "https://www.facebook.com/photo.php?fbid=10209321242442220&set=a.1908663150443.2108294.1057751927&type=3",
                    "from": [
                        "id": "10208854387451137",
                        "name": "Marios Tsekis"
                    ],
                    "picture": "https://scontent.xx.fbcdn.net/v/t1.0-0/s130x130/15894983_10209321242442220_342243781888644727_n.jpg?oh=80d63b5741590e1c22cb74fc9f07db47&oe=58E779B6",
                    "type": "photo",
                    "updated_time": "2017-01-08T20:31:59+0000",
                    "status_type": "added_photos",
                    "story": "Marios Tsekis added 2 new photos — with Lia Tseki and 6 others at Little Archies Reichenbach.",
                    "object_id": "10209321242442220",
                    "privacy": [
                        "friends": "",
                        "value": "ALL_FRIENDS",
                        "deny": "",
                        "description": "Your friends",
                        "allow": ""
                    ],
                    "name": "Photos from Marios Tsekis's post"
                ]
            ],
            "id": 7771,
            "lastUpdated": "2017-01-08T21:21:26.184Z"
        ]

        let array: [JSON] = [obj1, obj2]

        let result: [HATFacebook] = HATFacebookService.removeDuplicatesFrom(array: array)

        XCTAssertTrue(result.count == 1)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
