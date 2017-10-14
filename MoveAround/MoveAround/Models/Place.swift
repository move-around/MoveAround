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
    var distance: String?
    var hours: String?
    var ratingImageURL: URL?
    var reviewCount: NSNumber?
    var itineraryTime: String?  // Will probs change be a enum/struct
    
    override init() {
        super.init()
    }
}
