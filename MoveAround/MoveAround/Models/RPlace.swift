//
//  RPlace.swift
//  MoveAroundTests
//
//  Created by Gonzalo Maldonado Martinez on 10/27/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import RealmSwift

class RPlace: Object {
    @objc dynamic var name: String? = nil
    @objc dynamic var address: String? = nil
    @objc dynamic var imageURL: String? = nil
    @objc dynamic var categories: String? = nil
    @objc dynamic var distance: String? = nil
    @objc dynamic var hours: String? = nil
    @objc dynamic var ratingImageURL: String? = nil
    @objc dynamic var reviewCount: NSNumber? = 0
    @objc dynamic var itineraryTime: String? = nil  // Will probs change be a enum/struct
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var phoneNumber: String? = nil
    @objc dynamic var id: String? = nil
    @objc dynamic var isSelected: Bool  = false
}
