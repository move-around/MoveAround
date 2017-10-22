//
//  PlaceSwipeableSuperView.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/14/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import MBProgressHUD

class PlaceSwipeableSuperView: UIView, PlaceSwipeableViewDelegate {
    var loadedViews: [PlaceSwipeableView]! = [PlaceSwipeableView]()
    var places: [Place]! = [Place]()
    let limit = 5
    var offset = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        super.layoutSubviews()
        populatePlaces()
    }
    
    func loadPlaceViews() {
        for (index, place) in places.enumerated() {
            let newView: PlaceSwipeableView = PlaceSwipeableView(frame: CGRect.init(x: 0, y: 0, width: 300, height: 340))
            newView.place = place
            newView.delegate = self
            
            loadedViews.append(newView)
            if index > 0 {
                self.insertSubview(loadedViews[index], belowSubview: loadedViews[index-1])
            } else {
                self.addSubview(loadedViews[index])
            }
        }
    }
    
    fileprivate func swipeClear() {
        loadedViews.removeFirst()
        if loadedViews.count == 0 {
            populatePlaces()
        }
    }
    
    func swipedLeft(place: Place) {
        swipeClear()
        // Store user preferences etc
    }
    
    func swipedRight(place: Place) {
        swipeClear()
        // Store user preferences etc
        place.isSelected = true
        Itinerary.currentItinerary.placesOfInterest.append(place)
    }
    
    func clickedLeft() {
        let topview = loadedViews.first!
        topview.removeFromSuperview()
        swipeClear()
        // Store user preferences etc
    }
    
    func clickedRight() {
        let topview = loadedViews.first!
        topview.removeFromSuperview()
        swipeClear()
        // Store user preferences etc
    }
    
    func populatePlaces() {
        // For now, let's just do a Yelp search.
        let sort = YelpSortMode.bestMatched

        let categories = TempCache.sharedInstance.itinerary?.interests.map{$0.yelpCode}
        let location = TempCache.sharedInstance.itinerary?.destination
        
        // Display HUD right before the request is made
        MBProgressHUD.showAdded(to: self, animated: true)
        
        // Perform request to Yelp API to get the list of places
        YelpPlace.searchWithTerm(term: nil, location: location, sort: sort, categories: categories, deals: false, radius: nil, limit:  limit, offset: offset) { (places: [Place]?, error: Error?) in
            if let places = places {
                self.places = places
                self.loadPlaceViews()
                self.offset += self.limit
            }
            MBProgressHUD.hide(for: self, animated: true)

        }
        
//        FoursquarePlace.search(query: "thai", near: "San Francisco,CA") { (places: [Place]?, error: Error?) in
//            if let places = places {
//                self.places = places
//                self.loadPlaceViews()
//                self.offset += self.limit
//            }
//        }
        
        
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}


