//
//  ParseModels.swift
//  MoveAround
//
//  Created by Gonzalo Maldonado Martinez on 10/25/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import Foundation
import Parse

class PCategory: PFObject {
    @NSManaged var name: NSString
    @NSManaged var yelpCode: NSString
    class func parseClassName() -> String {
        return "Category"
    }
}

class PPlace: PFObject {
    @NSManaged var name: NSString
    @NSManaged var address: NSString
    @NSManaged var imageURL: NSURL
    @NSManaged var categories: PFRelation<PCategory>
    @NSManaged var distance: NSString
    @NSManaged var hours: NSString
    @NSManaged var ratingImageURL: NSURL
    @NSManaged var reviewCount: Int
    @NSManaged var itineraryTime: NSString
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var phoneNumber: NSString
    @NSManaged var id: NSString
    @NSManaged var isSelected: Bool

    class func parseClassName() -> String {
        return "Place"
    }
}

class PPlaceItinerary: PFObject {
    @NSManaged var place: PFRelation<PPlace>
    @NSManaged var from: NSDate
    @NSManaged var to: NSDate

    class func parseClassName() -> String {
        return "PlaceIteinerary"
    }
}

class PDayItinerary: PFObject {
    @NSManaged var placesItineraries: PFRelation<PPlaceItinerary>

    class func parseClassName() -> String {
        return "DayItinerary"
    }
}


class PItinerary: PFObject {
    @NSManaged var user: PFUser
    @NSManaged var destination: NSString
    @NSManaged var startDate: NSDate
    @NSManaged var endDate: NSDate
    @NSManaged var interests: PFRelation<PCategory>
    @NSManaged var placesOfInterest: PFRelation<PPlace>
    @NSManaged var plannedPlaces: PFRelation<PPlace>

    class func parseClassName() -> String {
        return "Itinerary"
    }

    class func from(itinerary: Itinerary) {

    }
}
