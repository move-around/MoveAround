//
//  RItineraryTests.swift
//  MoveAround
//
//  Created by Gonzalo Maldonado Martinez on 10/26/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//
// NOTE: To run these tests, you will need to swap the TargetMemberships of RItinerary, RACategory and others to MoveAroundTests
// You will also need to comment out any existing calls to RItinerary on MoveAround Target Members

import XCTest
class RItineraryTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCreateFromRItinerary() {
        let rItinerary = RItinerary()
        rItinerary.id = "Foo"
        rItinerary.userID = "Blah"
        let destination = "San Francisco, CA, United States"
        rItinerary.destination = destination

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let startDate = formatter.date(from: "2017/10/08 22:31")
        rItinerary.startDate = startDate
        let endDate = formatter.date(from: "2017/10/10 22:31")
        rItinerary.endDate = endDate
        let raCategory = RACategory()
        raCategory.selected = true
        raCategory.name = "categoryItem.name"
        raCategory.yelpCode = "categoryItem.yelpCode"
        rItinerary.interests.append(raCategory)

        let rPlace = RPlace()
        rPlace.name = "RplaceFoo"
        rPlace.hours = "RplaceHours"
        rItinerary.placesOfInterest.append(rPlace)
        rItinerary.plannedPlaces.append(rPlace)

        let user = User(dictionary: NSDictionary())
        user.id = "Blah"
        let itinerary = ItineraryAdapter.createFromRItinerary(rItinerary: rItinerary, user: user)
        XCTAssertEqual(rItinerary.id, itinerary.id)
        XCTAssertEqual(rItinerary.userID, user.id)
        XCTAssertEqual(rItinerary.destination, itinerary.destination)
        XCTAssertEqual(rItinerary.startDate, itinerary.startDate)
        XCTAssertEqual(rItinerary.endDate, itinerary.endDate)
        XCTAssertEqual(rItinerary.interests[0].name, itinerary.interests.first!.name)
        XCTAssertEqual(rItinerary.interests[0].yelpCode, itinerary.interests.first!.yelpCode)
        XCTAssertEqual(rItinerary.interests[0].selected, itinerary.interests.first!.isSelected)
        XCTAssertEqual(rItinerary.placesOfInterest[0].name, itinerary.placesOfInterest.first!.name)
        XCTAssertEqual(rItinerary.placesOfInterest[0].hours, itinerary.placesOfInterest.first!.hours)
        XCTAssertEqual(rItinerary.plannedPlaces[0].name, itinerary.plannedPlaces.first!.name)
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

        let place = Place()
        place.name = "Home"
        place.hours = "9 to 5"
        itinerary.placesOfInterest.append(place)
        itinerary.plannedPlaces.append(place)

        let placeItinerary = PlaceItinerary()
        placeItinerary.place = place
        placeItinerary.from = startDate
        placeItinerary.to = endDate

        let dayItinerary = DayItinerary()
        dayItinerary.placesItineraries.append(placeItinerary)
        itinerary.dayItineraries.append(dayItinerary)

        let rItinerary = ItineraryAdapter.createFromItinerary(itinerary: itinerary)
        XCTAssertEqual(rItinerary.id, itinerary.id)
        XCTAssertEqual(rItinerary.userID, user.id)
        XCTAssertEqual(rItinerary.destination, destination)
        XCTAssertEqual(rItinerary.startDate, startDate)
        XCTAssertEqual(rItinerary.endDate, endDate)
        XCTAssertEqual(rItinerary.interests[0].name, category.name)
        XCTAssertEqual(rItinerary.interests[0].yelpCode, category.yelpCode)
        XCTAssertEqual(rItinerary.interests[0].selected, true)
        XCTAssertEqual(rItinerary.placesOfInterest[0].name, place.name)
        XCTAssertEqual(rItinerary.plannedPlaces[0].hours, place.hours)
        let firstDayItinerary = rItinerary.dayItineraries.first
        let firstPlaceItinerary = firstDayItinerary!.placesItineraries.first
        XCTAssertEqual(firstPlaceItinerary!.place!.name, place.name)
    }
}
