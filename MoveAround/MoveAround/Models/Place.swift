//
//  Place.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/13/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.

import UIKit

class Place: NSObject {
    var name: String?
    var address: String?
    var imageURL: URL?
    var categories: String?
    var internalCategories: String?
    var distance: String?
    var hours: String?
    var ratingImage: String?
    var reviewCount: NSNumber?
    var itineraryTime: String?  // Will probs change be a enum/struct
    var latitude: Double?
    var longitude: Double?
    var phoneNumber: String?
    var id: String?
    var url: String?
    var reservationURL: String?
    var positionVector: Vector?
    var travelTimeFromPrevPlace: String = ""
    
    var isSelected: Bool?  = false
    
    override init() {
        super.init()
    }
}

