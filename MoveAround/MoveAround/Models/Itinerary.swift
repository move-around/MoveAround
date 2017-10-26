//
//  Itinerary.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/21/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//
import UIKit
import Parse

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
        let pfObject = PItinerary()
        pfObject.parseUser = PFUser.current()!
        if let destination = self.destination {
            pfObject.destination = destination as NSString
        }
        if let startDate = self.startDate {
            pfObject.startDate = startDate as NSDate
        }
        if let endDate = self.endDate {
            pfObject.endDate = endDate as NSDate
        }
        self.interests.forEach { (categoryItem) in
            let pCategory = PCategory()
            pCategory.name = categoryItem.name as NSString
            pCategory.yelpCode = categoryItem.yelpCode as NSString
            pCategory.saveEventually()
        }
        self.plannedPlaces.forEach { (place) in
            let pplace = PPlace()

            if let placeName = place.name {
                pplace.name = placeName as NSString
            }

            if let address = place.address {
                pplace.address = address as NSString
            }

            if let imageUrl = place.imageURL {
                pplace.imageURL = imageUrl as NSURL
            }

            if let categories = place.categories {
                pplace.categories = categories as NSString
            }

            if let distance = place.distance {
                pplace.distance = distance as NSString
            }
        }
    }
}



