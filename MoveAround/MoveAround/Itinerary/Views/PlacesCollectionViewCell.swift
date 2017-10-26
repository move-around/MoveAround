//
//  PlacesCollectionViewCell.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/15/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class PlacesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placePriceRance: UILabel!
    @IBOutlet weak var placeType: UILabel!
    @IBOutlet weak var placeSelectedImage: UIImageView!
    
    var place: Place? {
        didSet {
            if let placeImageUrl: URL = place?.imageURL {
                placeImageView.setImageWith(placeImageUrl)
            }
            placeName.text = place?.name
            // TODO (mohit) Make this better, also set price range somehow
            placeType.text = place?.categories?.split(separator: ",")[0].lowercased()
            
            if (Itinerary.currentItinerary.placesOfInterest.filter{$0.id == place?.id}.count > 0 ||
                Itinerary.currentItinerary.plannedPlaces.filter{$0.id == place?.id}.count > 0) {
                place?.isSelected = true
                placeSelectedImage.tintColor = UIColor.blue
            }
            else {
                placeSelectedImage.tintColor = UIColor.lightGray
            }
            
        }
    }
    var isPreSelected: Bool = false {
        didSet {
            if !isPreSelected {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPlace))
                placeSelectedImage.addGestureRecognizer(tapGesture)
                if place?.isSelected == true {
                    placeSelectedImage.tintColor = UIColor.blue
                }
                else {
                    placeSelectedImage.tintColor = UIColor.lightGray
                }            }
            else {
                placeSelectedImage.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc func selectPlace() {
        place?.isSelected = !((place?.isSelected!)!)
        if ((place?.isSelected)!) {
            Itinerary.currentItinerary.placesOfInterest.append(place!)
            placeSelectedImage.tintColor = UIColor.blue
        }
        else {
            if let index = Itinerary.currentItinerary.placesOfInterest.index(of: place!) {
                Itinerary.currentItinerary.placesOfInterest.remove(at: index)
            }
            placeSelectedImage.tintColor = UIColor.lightGray
        }
        Itinerary.currentItinerary.storeInParse()
    }

    
    
}

