//
//  ItineraryData.swift
//  MoveAround
//
//  Created by Mohit Taneja on 11/12/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class ItineraryData: NSObject {

    static let itineraryList = ["San Francisco, CA, United States": ["touristItinerary": touristItineraryForSF],
                                "Manhattan Beach, CA, United States": ["touristItinerary": touristItineraryForManhattanBeach]
                                ]
    // Demo Itinerary
    static let touristItineraryForSF = [[["hollywood-cafe-san-francisco","Breakfast at"],
                                         ["pier-39-san-francisco",""],
                                         ["tonys-pizza-napoletana-san-francisco","Lunch at"],
                                         ["coit-tower-san-francisco",""],
                                         ["coqueta-san-francisco","Dinner at"],
                                         ["exploratorium-after-dark-san-francisco-2",""],
                                         ["cafe-terminus-san-francisco","Drinks at"]],
                                        [["fog-baby-cafe-san-francisco","Breakfast at"],
                                         ["sutro-baths-san-francisco",""],
                                         ["lands-end-trail-san-francisco",""],
                                         ["koja-kitchen-san-francisco-7","Lunch at"],
                                         ["golden-gate-bridge-san-francisco",""],
                                         ["crissy-field-center-san-francisco-2",""],
                                         ["roma-antica-san-francisco-3","Dinner at"]]]
    
    static let touristItineraryForManhattanBeach = [[["north-end-caffe-manhattan-beach-3","Breakfast at"],
                                          ["manhattan-village-manhattan-beach-2",""],
                                          ["manhattan-beach-post-manhattan-beach","Lunch at"],
                                          ["manhattan-beach-bike-path-manhattan-beach",""],
                                          ["downtown-manhattan-beach-manhattan-beach",""],
                                          ["little-sister-manhattan-beach","Dinner at"],
                                          ["strand-bar-manhattan-beach","Drinks at"]],
                                         [["corner-bakery-cafe-manhattan-beach","Breakfast at"],
                                          ["hermosa-beach-pier-hermosa-beach",""],
                                          ["marthas-22nd-street-grill-hermosa-beach","Lunch at"],
                                          ["paradis-hermosa-beach-2",""],
                                          ["palos-verdes-beach-palos-verdes-estates",""],
                                          ["del-amo-fashion-center-torrance",""],
                                          ["paul-martins-american-grill-el-segundo-3","Dinner at"]]]
}
