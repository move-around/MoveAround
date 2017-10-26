//
//  Itinerary.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/21/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//
import UIKit

// Representation of a single itinerary item
class PlaceItinerary: NSObject {
    var place: Place?
    var from: Date?
    var to: Date?
}

// Representation of itinerary for a day
class DayItinerary: NSObject {
    var placesItineraries: [PlaceItinerary?] = [PlaceItinerary?](repeating: nil, count:10)
}

class Itinerary: NSObject {
    var user: User?
    var destination: String?
    var startDate: Date?
    var endDate: Date?
    var interests: [CategoryItem] = [CategoryItem]()
    var placesOfInterest: [Place] = [Place]() // Places the user wants to visit
    var plannedPlaces: [Place] = [Place]() // Places selected as part of itinerary
    var dayItineraries: [DayItinerary?] = [DayItinerary?]()
    
    override init() {
        super.init()
    }
    
    class func getCurrentItinerary()->Itinerary {
        return currentItinerary
    }
    
    static var currentItinerary: Itinerary = Itinerary()

    func storeInParse() {
        // TODO
    }
}



