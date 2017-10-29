//
//  Itinerary.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/21/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//
import UIKit

// Representation of a single itinerary item
class PlaceItinerary: NSObject {
    var place: Place?
    var from: Date?
    var to: Date?
}

// Representation of itinerary for a day
class DayItinerary: NSObject {
    var placesItineraries: [PlaceItinerary?] = [PlaceItinerary?](repeating: nil, count:6)
    var potentialPlacesToVisit: [Place] = []
}

class Itinerary: NSObject {
    var user: User?
    var destination: String?
    var startDate: Date?
    var endDate: Date?
    var interests: [CategoryItem] = [CategoryItem]()
    var placesOfInterest: [Place] = [Place]() // Places the user wants to visit
    var plannedPlaces: [Place] = [Place]() // Places selected as part of itinerary
    var dayItineraries: [DayItinerary?] = [DayItinerary?]()
    var initialTimeSlots: [[String]] = [["9:00 AM", "10:00 AM"],
                                        ["10:30 AM", "1:00 PM"],
                                        ["1:30 PM", "2:30 PM"],
                                        ["3:00 PM", "4:30 PM"],
                                        ["5:00 PM", "7:00 PM"],
                                        ["7:30 PM", "9:00 PM"]]
    
    let placePreferencesForTimeSlots: [[String]] = [["breakfast_brunch", "coffee", "cafes"],
                                        ["not_restaurant"],
                                        ["restaurant"],
                                        ["not_restaurant"],
                                        ["coffee", "cafes"],
                                        ["restaurant"]]

    
    
    
    override init() {
        super.init()
    }
    
    class func getCurrentItinerary()->Itinerary {
        return currentItinerary
    }
    
    static var currentItinerary: Itinerary = Itinerary()
    
    func generateItinerary() {
        // First copy all the planned places to places of interest,
        // in case we are recreating the itinerary
        placesOfInterest.append(contentsOf: plannedPlaces);
        plannedPlaces.removeAll()
        
        // Create an array of vectors from the planned places
        var placesVector: [Vector] = []
        for place in placesOfInterest {
            placesVector.append(place.positionVector!)
        }
        
        // Create clusters using K-Means
        let convergenceDistance = 0.0001
        let labels: [Int] = Array(0...dayItineraries.count-1)
        let kmm = KMeans<Int>(labels: labels)
        kmm.trainCenters(placesVector, convergeDistance: convergenceDistance)
        
        var labelArrayForPlacesVector = kmm.fit(placesVector)
        
        for i in 0..<labelArrayForPlacesVector.count {
            let label = labelArrayForPlacesVector[i]
            print("\(label): \(placesVector[i])")
            if (dayItineraries[label] == nil) {
                dayItineraries[label] = DayItinerary()
            }
            dayItineraries[label]?.potentialPlacesToVisit.append(placesOfInterest[i])
        }
        
        // Now create itinerary for each day based upon potentialPlaces to visit
        for dayItinerary in dayItineraries {
            if dayItinerary != nil {
                createDayItinerary(dayItinerary: dayItinerary!)
            }
        }
    }
    
    func createDayItinerary(dayItinerary: DayItinerary) {
        for i in 0..<dayItinerary.placesItineraries.count {
            if dayItinerary.placesItineraries[i] == nil {
                dayItinerary.placesItineraries[i] = PlaceItinerary()
            }
            // Do more fancy stuff here regarding how to select a place
            let placeToVisit = placeToVisitBasedOnPreferences(preferences: placePreferencesForTimeSlots[i], dayItinerary: dayItinerary)
            
            if placeToVisit != nil {
                dayItinerary.placesItineraries[i]?.place = placeToVisit
            
                // Also every time we add a place to itinerary,
                // add it to plannedPlaces and remove it from placesOfInterest
                plannedPlaces.append(placeToVisit!)
                placesOfInterest.remove(at: placesOfInterest.index(of: placeToVisit!)!)
            }
        }
    }
    
    // Select only one place to be visited for a particular placeItinerary
    // based on preferences array for categories for places
    func placeToVisitBasedOnPreferences(preferences: [String], dayItinerary: DayItinerary)->Place? {
        var selectedPlace: Place? = nil
        
        // Go through each place in the potential places to visit
        for place in dayItinerary.potentialPlacesToVisit {
            let categoriesForPlace = place.internalCategories!.split(separator: ",")
            
            // Check if even one of their category belongs to the preferred category for that time slot
            for preferredCategory in preferences {
                let isPlaceRestaurant = YelpCategoryMatcher.isCategoryRestaurant(categories: categoriesForPlace)
                if preferredCategory == "restaurant" && isPlaceRestaurant {
                    selectedPlace = place
                    dayItinerary.potentialPlacesToVisit.remove(at: dayItinerary.potentialPlacesToVisit.index(of: selectedPlace!)!)
                    return selectedPlace
                }
                else if preferredCategory == "not_restaurant" && !isPlaceRestaurant {
                    selectedPlace = place
                    dayItinerary.potentialPlacesToVisit.remove(at: dayItinerary.potentialPlacesToVisit.index(of: selectedPlace!)!)
                    return selectedPlace
                }
                else if categoriesForPlace.contains(preferredCategory.split(separator: ",")[0]) {
                    selectedPlace = place
                    dayItinerary.potentialPlacesToVisit.remove(at: dayItinerary.potentialPlacesToVisit.index(of: selectedPlace!)!)
                    return selectedPlace
                }
            }
        }
        
        // If we are reaching here, this means that we weren't able to find any suitable place for this time slot
        return selectedPlace
    }
}



