//
//  ItineraryCell.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/17/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

@IBDesignable
class ItineraryCell: UITableViewCell {
  
  @IBOutlet var cellContentView: UIView!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    initSubviews()
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initSubviews()
  }
  
  func initSubviews() {
    // standard initialization logic
    let nib = UINib(nibName: "ItineraryCell", bundle: Bundle(for: type(of: self)))
    nib.instantiate(withOwner: self, options: nil)
    cellContentView.bounds = bounds
    self.addSubview(contentView)
  }
  
}

