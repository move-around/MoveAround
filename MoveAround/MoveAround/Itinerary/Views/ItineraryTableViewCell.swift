//
//  ItineraryTableViewCell.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/20/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

protocol ItineraryTableViewDelegate {
    func showSelectedPlaces(cell: UITableViewCell)
}

class ItineraryTableViewCell: UITableViewCell {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var travelTimeLabel: UILabel!
    @IBOutlet weak var switchPlaceImage: UIImageView!
    @IBOutlet weak var bannerButton: UIButton!
    
    var placeItinerary: PlaceItinerary = PlaceItinerary()
    
    var place: Place? {
        didSet {
            if let placeImageUrl: URL = place?.imageURL {
                placeImage.setImageWith(placeImageUrl)
            }
            placeName.text = place?.name
            placeAddress.text = place?.address
            bannerButton.isHidden = true
            placeItinerary.place = place!
        }
    }
    
    var travelTime: String? {
        didSet {
            travelTimeLabel.text = travelTime!
        }
    }
    
    var delegate: ItineraryTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchPlaceImage.tintColor = UIColor.darkGray
        // Add Tap gesture recognizers
        let gestureRecornizerForSelectingPlaces = UITapGestureRecognizer(target: self, action: #selector(showPlaceSelector(_:)))
        switchPlaceImage.addGestureRecognizer(gestureRecornizerForSelectingPlaces)
        gestureRecornizerForSelectingPlaces.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showPlaceSelector(_ sender: Any) {
        delegate?.showSelectedPlaces(cell: self)
    }
}
