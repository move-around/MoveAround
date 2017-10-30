//
//  InterestSelectionCell.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/29/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class InterestSelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var item: CategoryItem! {
        didSet {
            categoryLabel.text = item.name
            categoryImage.image = UIImage(named: item.imageName)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.black : UIColor.clear
            categoryImage.alpha = isSelected ? 0.45 : 1.0
            self.categoryLabel.textColor = isSelected ? UIColor.init(red: 255/255, green: 113/255, blue: 18/255, alpha: 1) : UIColor.white
        }
    }
}

