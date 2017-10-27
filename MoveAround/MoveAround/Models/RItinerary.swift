//
//  RItinerary.swift
//  MoveAround
//
//  Created by Gonzalo Maldonado Martinez on 10/26/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import Foundation
import RealmSwift

class RPlaceItinerary: Object {
    @objc dynamic var place: RPlace? = nil
    @objc dynamic var from: Date? = nil
    @objc dynamic var to: Date? = nil
}

class RDayItinerary: Object {
    let placesItineraries = List<RPlaceItinerary>()
}

class RItinerary: Object {
    @objc dynamic var id: String? = nil
    @objc dynamic var userID: String? = nil
    @objc dynamic var destination: String? = nil
    @objc dynamic var startDate: Date? = nil
    @objc dynamic var endDate: Date? = nil
    let interests = List<RACategory>()
    let placesOfInterest = List<RPlace>()
    let plannedPlaces = List<RPlace>()
    let dayItineraries = List<RDayItinerary>()

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
            let rPlace = self.createRPlaceFromPlace(place: place)
            rItinerary.placesOfInterest.append(rPlace)
        }
        itinerary.plannedPlaces.forEach { (place) in
            let rPlace = self.createRPlaceFromPlace(place: place)
            rItinerary.plannedPlaces.append(rPlace)
        }

        itinerary.dayItineraries.forEach { (dayItinerary) in
            let rDayItinerary = RDayItinerary()
            let filledItineraries = dayItinerary?.placesItineraries.filter({ (placeItinerary) -> Bool in
                return placeItinerary != nil
            })

            filledItineraries?.forEach({ (placeItinerary) in
                let rPlaceItinerary = RPlaceItinerary()
                rPlaceItinerary.place = self.createRPlaceFromPlace(place: placeItinerary!.place!)
                rPlaceItinerary.from = placeItinerary?.from
                rPlaceItinerary.to = placeItinerary?.to
                rDayItinerary.placesItineraries.append(rPlaceItinerary)
            })
            if let count = filledItineraries?.count {
                if (count > 0) {
                    rItinerary.dayItineraries.append(rDayItinerary)
                }
            }
        }
        return rItinerary
    }

    class func createRPlaceFromPlace(place: Place) -> RPlace {
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
        return rPlace
    }

}
