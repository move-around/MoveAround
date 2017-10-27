//
//  RItinerary.swift
//  MoveAround
//
//  Created by Gonzalo Maldonado Martinez on 10/26/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import Foundation
import RealmSwift

class RAItinerary: Object {
    @objc dynamic var userID: String? = nil
    @objc dynamic var destination: String? = nil

}


class ItineraryAdapter {
    static func createFromItinerary(itinerary: Itinerary) -> RAItinerary {
        let rItinerary = RAItinerary()
        rItinerary.userID = itinerary.user?.id ?? nil
        rItinerary.destination = itinerary.destination
        return rItinerary
    }
}
