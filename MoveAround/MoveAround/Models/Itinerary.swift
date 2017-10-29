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
        let numOfPlacesToVisit: Int = min(dayItinerary.placesItineraries.count, dayItinerary.potentialPlacesToVisit.count)
        for i in 0..<numOfPlacesToVisit {
            if dayItinerary.placesItineraries[i] == nil {
                dayItinerary.placesItineraries[i] = PlaceItinerary()
            }
            // Do more fancy stuff here regarding how to select a place
            let placeToVisit = dayItinerary.potentialPlacesToVisit[i]
            dayItinerary.placesItineraries[i]?.place = placeToVisit
            
            // Also every time we add a place to itinerary,
            // add it to plannedPlaces and remove it from placesOfInterest
            plannedPlaces.append(placeToVisit)
            placesOfInterest.remove(at: placesOfInterest.index(of: placeToVisit)!)
        }
    }
}



