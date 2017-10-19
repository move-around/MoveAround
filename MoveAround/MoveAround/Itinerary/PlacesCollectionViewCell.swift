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
      
    }
  }
}
