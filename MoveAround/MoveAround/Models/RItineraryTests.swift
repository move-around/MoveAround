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

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let startDate = formatter.date(from: "2017/10/08 22:31")
        itinerary.startDate = startDate
        let endDate = formatter.date(from: "2017/10/10 22:31")
        itinerary.endDate = endDate

        let category = Category(name: "CategoryFoo", yelpCode: "CategoryBar")
        let categoryItem = CategoryItem(item: category)
        categoryItem.isSelected = true
        itinerary.interests.append(categoryItem)

        let rItinerary = ItineraryAdapter.createFromItinerary(itinerary: itinerary)
        XCTAssertEqual(rItinerary.id, itinerary.id)
        XCTAssertEqual(rItinerary.userID, user.id)
        XCTAssertEqual(rItinerary.destination, destination)
        XCTAssertEqual(rItinerary.startDate, startDate)
        XCTAssertEqual(rItinerary.interests[0].name, category.name)
        XCTAssertEqual(rItinerary.interests[0].yelpCode, category.yelpCode)
        XCTAssertEqual(rItinerary.interests[0].selected, true)
        XCTAssertEqual(rItinerary.endDate, endDate)
    }
}
