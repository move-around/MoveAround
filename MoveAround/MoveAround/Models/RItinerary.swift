//
//  RItinerary.swift
//  MoveAround
//
//  Created by Gonzalo Maldonado Martinez on 10/26/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import Foundation
import RealmSwift

class RItinerary: Object {
    @objc dynamic var id: String? = nil
    @objc dynamic var userID: String? = nil
    @objc dynamic var destination: String? = nil
    @objc dynamic var startDate: Date? = nil
    @objc dynamic var endDate: Date? = nil
    let interests = List<RACategory>()
    let placesOfInterest = List<RPlace>()

    override static func primaryKey() -> String? {
        return "id"
    }
}

class ItineraryAdapter {
    static func createFromItinerary(itinerary: Itinerary) -> RItinerary {
        let rItinerary = RItinerary()
        rItinerary.id = itinerary.id
        rItinerary.userID = itinerary.user?.id ?? nil
        rItinerary.destination = itinerary.destination
        rItinerary.startDate = itinerary.startDate
        rItinerary.endDate = itinerary.endDate
        itinerary.interests.forEach { (categoryItem) in
            let raCategory = RACategory()
            raCategory.selected = categoryItem.isSelected
            raCategory.name = categoryItem.name
            raCategory.yelpCode = categoryItem.yelpCode
            rItinerary.interests.append(raCategory)
        }
        itinerary.placesOfInterest.forEach { (place) in
            let rPlace = RPlace()
            rPlace.name = place.name
            rPlace.address = place.address
            rPlace.imageURL = place.imageURL?.absoluteString
            rPlace.categories = place.categories
            rPlace.distance = place.distance
            rPlace.hours = place.hours
            rPlace.ratingImageURL = place.ratingImageURL?.absoluteString
            rPlace.reviewCount = place.reviewCount
            rPlace.itineraryTime = place.itineraryTime
            rPlace.latitude = place.latitude ?? 0.0
            rPlace.longitude = place.longitude ?? 0.0
            rPlace.phoneNumber = place.phoneNumber
            rPlace.id = place.id
            rPlace.isSelected = place.isSelected ?? false
            rItinerary.placesOfInterest.append(rPlace)
        }
        return rItinerary
    }
}
