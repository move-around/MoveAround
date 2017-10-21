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
    
    func swipedLeft() {
        swipeClear()
        // Store user preferences etc
    }
    
    func swipedRight() {
        swipeClear()
        // Store user preferences etc
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
        let location = "San Francisco" // Hard-code this now for testing
        let sort = YelpSortMode.bestMatched

        let categoryItems = TempCache.sharedInstance.categoryItems!
        let categories = categoryItems.map{$0.yelpCode}
        
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


