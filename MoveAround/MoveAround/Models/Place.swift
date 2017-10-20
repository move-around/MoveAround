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
    var latitude: Double?
    var longitude: Double?
    var phoneNumber: String?
    
    var isSelected: Bool?  = false {
        didSet {
            if oldValue != isSelected {
                if isSelected! {
                    Place.selectedPlaces.append(self)
                }
                else {
                    if let index = Place.selectedPlaces.index(of: self) {
                        Place.selectedPlaces.remove(at: index)
                    }
                }
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    // List of places user has selected to visit
    static var selectedPlaces: [Place] = []

}

