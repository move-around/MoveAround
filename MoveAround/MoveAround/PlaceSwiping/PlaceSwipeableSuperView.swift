//
//  PlaceSwipeableSuperView.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/14/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import KRProgressHUD

protocol PlaceSwipeableSuperViewDelegate {
    func clickedImage()
}

class PlaceSwipeableSuperView: UIView, PlaceSwipeableViewDelegate {
    var loadedViews: [PlaceSwipeableView]! = [PlaceSwipeableView]()
    var places: [Place]! = [Place]()
    let limit = 40
    var offset = 0
    var delegate: PlaceSwipeableSuperViewDelegate!
    
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
            let newView: PlaceSwipeableView = PlaceSwipeableView(frame: CGRect.init(x: (self.frame.width - 350)/2, y: 80, width: 350, height: 450))
            newView.place = place
            newView.delegate = self
            
            // shadow
//            newView.layer.shadowColor = UIColor.black.cgColor
//            newView.layer.shadowOffset = CGSize(width: 3, height: 3)
//            newView.layer.shadowOpacity = 0.2
//            newView.layer.shadowRadius = 4

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
    
    func clickedImage() {
        delegate.clickedImage()
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
        topview.moveLeft()
        swipeClear()
        // Store user preferences etc
    }
    
    func clickedRight() {
        let topview = loadedViews.first!
        Itinerary.currentItinerary.placesOfInterest.append(topview.place)
        topview.moveRight()
        swipeClear()
        // Store user preferences etc
    }
    
    func populatePlaces() {
        // For now, let's just do a Yelp search.
        let sort = YelpSortMode.rating

        let categories = TempCache.sharedInstance.itinerary?.interests.map{$0.yelpCode}
        let location = TempCache.sharedInstance.itinerary?.destination
        
        // Display HUD right before the request is made
        KRProgressHUD
            .set(style: .white)
            .set(maskType: .white)
            .set(activityIndicatorViewStyle: .gradationColor(head: .orange, tail: .orange))
            .show()
        
        // Perform request to Yelp API to get the list of places
        YelpPlace.searchWithTerm(term: nil, location: location, sort: sort, categories: categories, deals: false, radius: nil, limit:  limit, offset: offset) { (places: [Place]?, error: Error?) in
            if let places = places {
                self.places = places
                self.loadPlaceViews()
                self.offset += self.limit
            }
            
            KRProgressHUD.dismiss()
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


