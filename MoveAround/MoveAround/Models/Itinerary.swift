//
//  Itinerary.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/21/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//
import UIKit

class Itinerary: NSObject {
    var user: User?
    var destination: String?
    var startDate: Date?
    var endDate: Date?
    var interests: [CategoryItem] = [CategoryItem]()
    var swipedPlaces: [Place] = [Place]() // Swiped in Tinder view
    var plannedPlaces: [Place] = [Place]() // Selected as part of itinerary
    
    override init() {
        super.init()
    }
}



