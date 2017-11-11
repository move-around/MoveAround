//
//  ArchetypeCell.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 11/10/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class ArchetypeCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
