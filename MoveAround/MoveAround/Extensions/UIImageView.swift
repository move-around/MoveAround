//
//  UIImageView.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/24/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeCircular() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
}

