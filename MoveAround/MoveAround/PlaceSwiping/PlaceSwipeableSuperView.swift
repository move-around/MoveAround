//
//  PlaceSwipeableSuperView.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/14/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

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
            newView.name = place.name
            if let url = place.imageURL {
                newView.placeImageView.setImageWith(url)
            }
            newView.delegate = self
            
            loadedViews.append(newView)
            if index > 0 {
                self.insertSubview(loadedViews[index], belowSubview: loadedViews[index-1])
            } else {
                self.addSubview(loadedViews[index])
            }
        }
    }
    
    func swiped() {
        loadedViews.removeFirst()
        
        if loadedViews.count == 0 {
            populatePlaces()
        }
    }
    
    fileprivate func populatePlaces() {
        // For now, let's just do a Yelp search.
        let location = "San Francisco" // Hard-code this now for testing
        let term = "Landmarks"
        let sort = YelpSortMode.bestMatched
        
        // Perform request to Yelp API to get the list of places
        YelpPlace.searchWithTerm(term: term, location: location, sort: sort, categories: nil, deals: false, radius: nil, limit:  limit, offset: offset) { (places: [Place]?, error: Error?) in
            if let places = places {
                self.places = places
                self.loadPlaceViews()
                self.offset += self.limit
            }
        }
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}


