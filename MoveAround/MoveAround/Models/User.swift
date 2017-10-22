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

    private var dictionary: NSDictionary?

    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        if let dictId = dictionary["id"] as? String {
            id = dictId
        }
        if let dictFirstName = dictionary["first_name"] as? String {
            firstName = dictFirstName
        }
        if let dictLastName = dictionary["last_name"] as? String {
            lastName = dictLastName
        }
    }

    static private var _currentUser: User?
    class var currentUser: User? {
        get {
            if (_currentUser != nil) {
                return _currentUser
            }

            let data = UserDefaults.standard.object(forKey: "currentUserData") as? Data
            if (data != nil) {
                let dictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                _currentUser = User(dictionary: dictionary)
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
}



