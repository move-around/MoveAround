//
//  ItineraryData.swift
//  MoveAround
//
//  Created by Mohit Taneja on 11/12/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class ItineraryData: NSObject {

    static let itineraryList = ["San Francisco, CA, United States": ["touristItinerary": touristItineraryForSF, "foodieItinerary": foodieItineraryForSF],
                                "Manhattan Beach, CA, United States": ["touristItinerary": touristItineraryForManhattanBeach],
                                "Toronto, ON, Canada": ["partyItinerary": partyItineraryForToronto]
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
                                         ["roma-antica-san-francisco-3","Dinner at"]],
                                        [["craftsman-and-wolves-san-francisco","Breakfast at"],
                                         ["alamo-square-san-francisco",""],
                                         ["mission-dolores-park-san-francisco",""],
                                         ["la-taqueria-san-francisco-2","Lunch at"],
                                         ["clarion-alley-san-francisco",""],
                                         ["foreign-cinema-san-francisco","Dinner at"],
                                         ["bi-rite-creamery-san-francisco",""]]]
    
    static let foodieItineraryForSF = [[["outerlands-san-francisco", "Breakfast at"],
                                        ["rose-garden-san-francisco", ""],
                                        ["dragon-beaux-san-francisco", "Lunch at"],
                                        ["home-san-francisco-28", "Coffee at"],
                                        ["alamo-square-san-francisco", ""],
                                        ["liholiho-yacht-club-san-francisco-2", "Dinner at"],
                                        ["shakedown-san-francisco", ""]],
                                       [["morning-due-cafe-san-francisco", "Breakfast at"],
                                        ["clarion-alley-san-francisco", ""],
                                        ["ichido-san-francisco-6", "Lunch at"],
                                        ["special-xtra-2-san-francisco", ""],
                                        ["san-francisco-museum-of-modern-art-san-francisco-6", ""],
                                        ["swan-oyster-depot-san-francisco", "Dinner at"],
                                        ["hi-lo-club-san-francisco", "Drinks at"]]]
    
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
    
    static let partyItineraryForToronto = [[["lolas-kitchen-toronto","Breakfast at"],
                                         ["the-distillery-district-toronto",""],
                                         ["antler-kitchen-and-bar-toronto","Lunch at"],
                                         ["the-coffee-lab-toronto-2",""],
                                         ["her-fathers-cider-bar-and-kitchen-toronto","Dinner at"],
                                         ["cc-lounge-and-whisky-bar-toronto-2","Drinks at"],
                                         ["cube-toronto",""]],
                                       [["lolas-kitchen-toronto","Breakfast at"],
                                            ["the-distillery-district-toronto",""],
                                            ["antler-kitchen-and-bar-toronto","Lunch at"],
                                            ["the-coffee-lab-toronto-2",""],
                                            ["her-fathers-cider-bar-and-kitchen-toronto","Dinner at"],
                                            ["cc-lounge-and-whisky-bar-toronto-2","Drinks at"],
                                            ["cube-toronto",""]]]
}

