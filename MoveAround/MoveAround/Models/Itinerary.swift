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
    var placesItineraries: [PlaceItinerary?] = [PlaceItinerary?](repeating: nil, count:7)
    var placePurpose: [String] = [String](repeating: "", count: 7)
    var potentialPlacesToVisit: [Place] = []
}

class Itinerary: NSObject {
    var user: User?
    var destination: String?
    var startDate: Date?
    var endDate: Date?
    var interests: [CategoryItem] = [CategoryItem]()
    var placesOfInterest: [Place] = [Place]() // Places the user wants to visit
    var plannedPlaces: [Place] = [Place]() // Places selected as part of itinerary
    var unswipedInterestingPlaces: [Place] = [Place]() // Places that were loaded in the swiping view but not swiped
    var dayItineraries: [DayItinerary?] = [DayItinerary?]()
    
    override init() {
        super.init()
    }
    
    class func getCurrentItinerary()->Itinerary {
        return currentItinerary
    }
    
    static var currentItinerary: Itinerary = Itinerary()
    
    class func loadItinerary(itineraryData: [[[String]]]) -> Itinerary {
        let itinerary = Itinerary()
        for dayItineraryData in itineraryData {
            let dayItinerary = DayItinerary()
            for i in 0..<dayItineraryData.count {
                YelpPlace.businessForId(id: dayItineraryData[i][0], completion: { (place: Place?, error: Error?) in
                    dayItinerary.placesItineraries[i] = PlaceItinerary()
                    dayItinerary.placesItineraries[i]?.place = place
                    Itinerary.currentItinerary.plannedPlaces.append(place!)
                    dayItinerary.placePurpose[i] = dayItineraryData[i][1]
                })
            }
            itinerary.dayItineraries.append(dayItinerary)
        }
        return itinerary
    }
    
}



