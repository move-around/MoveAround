//
//  RCategory.swift
//  MoveAround
//
//  Created by Gonzalo Maldonado Martinez on 10/27/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import Foundation
import RealmSwift

class RACategory: Object {
    @objc dynamic var name: String? = nil
    @objc dynamic var yelpCode: String? = nil
    @objc dynamic var selected: Bool = false
}
