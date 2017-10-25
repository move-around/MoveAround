//
//  InterestSelectionCell.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/20/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class InterestSelectionCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    var item: CategoryItem? {
        didSet {
            categoryLabel?.text = item?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //accessoryType = selected ? .checkmark : .none
        // Ideally we store the orange color globally to access somewhere
        if selected {
            self.categoryLabel.textColor = UIColor.init(red: 255/255, green: 113/255, blue: 18/255, alpha: 1)
            self.categoryLabel.font = UIFont.boldSystemFont(ofSize: 18)
        } else {
            self.categoryLabel.textColor = .black
            self.categoryLabel.font = UIFont.systemFont(ofSize: 18)
        }
    }

}
