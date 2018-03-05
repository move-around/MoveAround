//
//  ItineraryCollectionViewCell.swift
//  MoveAround
//
//  Created by Mohit Taneja on 11/10/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

protocol ItineraryCollectionViewDelegate {
    func showSelectedPlaces(cell: UICollectionViewCell)
    func placeSelected(placeItinerary: PlaceItinerary, cell: UICollectionViewCell)
}

class ItineraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var switchPlaceImage: UIImageView!
    @IBOutlet weak var bannerButton: UIButton!
    @IBOutlet weak var imageCoverView: UIView!
    @IBOutlet weak var circularGradientImage: UIImageView!
    @IBOutlet weak var circularGradientImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var placePurposeLabel: UILabel!
    
    var placeItinerary: PlaceItinerary?
    
    var place: Place? {
        didSet {
            if (place != nil) {
                if let placeImageUrl: URL = place?.imageURL {
                    placeImage.setImageWith(placeImageUrl)
                }
                placeName.text = place?.name
                circularGradientImageWidthConstraint.constant = placeName.frame.width + 60
                placeAddress.text = place?.address
                bannerButton.isHidden = true
                if (placeItinerary == nil) {
                    placeItinerary = PlaceItinerary()
                }
                placeItinerary?.place = place!
                categoriesLabel.text = place?.categories ?? ""
            }
        }
    }
    
    var delegate: ItineraryCollectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Add Tap gesture recognizers
        let gestureRecognizerToResetCell = UITapGestureRecognizer(target: self, action: #selector(userClearedCell))
        switchPlaceImage.addGestureRecognizer(gestureRecognizerToResetCell)
        
        switchPlaceImage.tintColor = UIColor(hex: "FF7112")
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
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        
        // Update the subviews based upon movement of the cell
        let minAlpha: CGFloat = 0.01
        let maxAlpha: CGFloat = 0.50
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        categoriesLabel.alpha = delta
        switchPlaceImage.alpha = delta
        placeAddress.alpha = delta
        circularGradientImage.alpha = maxAlpha*delta
        circularGradientImageWidthConstraint.constant = placeName.frame.width + 60
    }

}
