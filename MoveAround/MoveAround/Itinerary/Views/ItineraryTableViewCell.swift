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
    func placeSelected(placeItinerary: PlaceItinerary, cell: UITableViewCell)
}

class ItineraryTableViewCell: UITableViewCell {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var travelTimeLabel: UILabel!
    @IBOutlet weak var switchPlaceImage: UIImageView!
    @IBOutlet weak var bannerButton: UIButton!
    
    var placeItinerary: PlaceItinerary?
    
    var place: Place? {
        didSet {
            if (place != nil) {
                if let placeImageUrl: URL = place?.imageURL {
                    placeImage.setImageWith(placeImageUrl)
                }
                placeName.text = place?.name
                placeAddress.text = place?.address
                bannerButton.isHidden = true
                if (placeItinerary == nil) {
                    placeItinerary = PlaceItinerary()
                }
                placeItinerary?.place = place!
                travelTimeLabel.text = place?.travelTimeFromPrevPlace
            }
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
        let gestureRecornizerForSelectingPlaces = UITapGestureRecognizer(target: self, action: #selector(userClearedCell))
        switchPlaceImage.addGestureRecognizer(gestureRecornizerForSelectingPlaces)
        gestureRecornizerForSelectingPlaces.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func userClearedCell() {
        Itinerary.currentItinerary.placesOfInterest.append(place!)
        Itinerary.currentItinerary.plannedPlaces.remove(at: Itinerary.currentItinerary.plannedPlaces.index(of: place!)!)
        placeItinerary?.place = nil
        delegate?.placeSelected(placeItinerary: placeItinerary!, cell: self)
        resetCell()
    }
    func resetCell() {
        bannerButton.isHidden = false
        place = nil
    }
    
    func setSelectedPlace(selectedPlace: Place) {
        self.place = selectedPlace
        if (delegate != nil) {
            delegate?.placeSelected(placeItinerary: placeItinerary!, cell: self)
        }
    }

    @IBAction func showPlaceSelector(_ sender: Any) {
        delegate?.showSelectedPlaces(cell: self)
    }
}
