//
//  User.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/15/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String!
    var firstName: String!
    var lastName: String?
    var destinationCity: String!
    var startDate: Date!
    var endDate: Date?
    
    var interests: [String]?
    var selectedPlaces: [Place]?
}
