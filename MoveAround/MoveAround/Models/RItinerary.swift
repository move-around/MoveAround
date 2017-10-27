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
        return rItinerary
    }
}
