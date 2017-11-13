//
//  ItineraryCreator.swift
//  MoveAround
//
//  Created by Mohit Taneja on 11/7/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class ItineraryCreator: NSObject {

    static let initialTimeSlots: [[String]] = [["9:00 AM", "10:00 AM"],
                                        ["10:30 AM", "1:00 PM"],
                                        ["1:30 PM", "2:30 PM"],
                                        ["3:00 PM", "4:30 PM"],
                                        ["5:00 PM", "7:00 PM"],
                                        ["7:30 PM", "9:00 PM"],
                                        ["9:30 PM", "11:00 PM"]]
    
    static let placePreferencesForTimeSlots: [[String]] = [["breakfast"],
                                                    ["landmark", "localFlavor", "parks", "arts", "active", "beautySpa"],
                                                    ["mexicanFood", "japaneseFood", "restaurant", "food"],
                                                    ["landmark", "localFlavor", "parks", "arts", "active", "beautySpa", "bicycle"],
                                                    ["coffee", "cafes"],
                                                    ["italianFood", "mediterraneanFood", "japaneseFood","restaurant"],
                                                    ["nightlife"]]
    
    static let placePurposeDefault : [String] = ["Breakfast at ",
                                                 "",
                                                 "Lunch at",
                                                 "",
                                                 "",
                                                 "Dinner at",
                                                 "Drinks at"]

    class func generateItinerary(itinerary: Itinerary) {
        // Before we create the itinerary we want to do some magic here,
        // lets say if the number of places you have slected that you would
        // want to visit is less than x*number (x~=10) of days in you itinerary
        // then we either try to classify your itinerary into something
        // that we already built based on what we already know of your
        // preferences based on the categories that you selected and the places you right swiped one
        
        // For now lets do this thing that if the number of places selected is less than
        // numDaysOfItinerary*8 we simply add all the remaining places to be swiped into selected places
        // TODO (Mohit) Fix this shit
        let dateInterval = DateInterval.init(start: itinerary.startDate!, end: itinerary.endDate!)
        let durationInDays = Int(round(dateInterval.duration/86400)) + 1
        if (itinerary.placesOfInterest.count < durationInDays*8) {
            itinerary.placesOfInterest.append(contentsOf: itinerary.unswipedInterestingPlaces)
        }

        // First copy all the planned places to places of interest,
        // in case we are recreating the itinerary
        itinerary.placesOfInterest.append(contentsOf: itinerary.plannedPlaces);
        itinerary.plannedPlaces.removeAll()
        
        // If number of places selected is less that number of days in itinerary just return
        if itinerary.placesOfInterest.count < itinerary.dayItineraries.count {
            return
        }
        // If num of days for itinerary is 1 or less, add all places to that day itself
        if itinerary.dayItineraries.count == 1 {
            itinerary.dayItineraries[0]?.potentialPlacesToVisit.append(contentsOf: itinerary.placesOfInterest)
        } else {
            // Create an array of vectors from the planned places
            var placesVector: [Vector] = []
            for place in itinerary.placesOfInterest {
                placesVector.append(place.positionVector!)
            }
            
            // Create clusters using K-Means
            let convergenceDistance = 0.0001
            let labels: [Int] = Array(0...itinerary.dayItineraries.count-1)
            let kmm = KMeans<Int>(labels: labels)
            kmm.trainCenters(placesVector, convergeDistance: convergenceDistance)
            
            var labelArrayForPlacesVector = kmm.fit(placesVector)
            
            for i in 0..<labelArrayForPlacesVector.count {
                let label = labelArrayForPlacesVector[i]
                if (itinerary.dayItineraries[label] == nil) {
                    itinerary.dayItineraries[label] = DayItinerary()
                }
                itinerary.dayItineraries[label]?.potentialPlacesToVisit.append(itinerary.placesOfInterest[i])
            }
        }
        
        // Now create itinerary for each day based upon potentialPlaces to visit
        for dayItinerary in itinerary.dayItineraries {
            if dayItinerary != nil {
                createDayItinerary(dayItinerary: dayItinerary!, itinerary: itinerary)
                dayItinerary?.placePurpose = placePurposeDefault
            }
        }
    }
    
    class func createDayItinerary(dayItinerary: DayItinerary, itinerary: Itinerary) {
        for i in 0..<dayItinerary.placesItineraries.count {
            if dayItinerary.placesItineraries[i] == nil {
                dayItinerary.placesItineraries[i] = PlaceItinerary()
            }
            // Do more fancy stuff here regarding how to select a place
            let placeToVisit = YelpCategoryMatcher.placeToVisitBasedOnPreferences(preferences: placePreferencesForTimeSlots[i], dayItinerary: dayItinerary)
            
            if placeToVisit != nil {
                dayItinerary.placesItineraries[i]?.place = placeToVisit
                
                // Also every time we add a place to itinerary,
                // add it to plannedPlaces and remove it from placesOfInterest
                itinerary.plannedPlaces.append(placeToVisit!)
                itinerary.placesOfInterest.remove(at: itinerary.placesOfInterest.index(of: placeToVisit!)!)
            }
        }
    }
    
}
