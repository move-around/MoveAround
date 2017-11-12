//
//  CityCell.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 11/11/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

