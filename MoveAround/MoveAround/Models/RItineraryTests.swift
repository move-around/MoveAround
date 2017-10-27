//
//  RItineraryTests.swift
//  MoveAround
//
//  Created by Gonzalo Maldonado Martinez on 10/26/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import XCTest

class RItineraryTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateFromItinerary() {
        let itinerary = Itinerary()
        let destination = "San Francisco, CA, United States"
        let user = User(dictionary: NSDictionary())
        user.id = "Blah"
        itinerary.user = user
        itinerary.destination = destination

        let rItinerary = ItineraryAdapter.createFromItinerary(itinerary: itinerary)
        XCTAssertEqual(rItinerary.userID, user.id)
        XCTAssertEqual(rItinerary.destination, destination)
    }
}
