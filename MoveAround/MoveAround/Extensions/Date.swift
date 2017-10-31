//
//  Date.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/31/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import Foundation

extension Date {
    static let formatterOut: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE, MMM d"
        return formatter
    }()
    
    static let formatterOutWithYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE, MMM d, YYYY"
        return formatter
    }()
    
    init(date:Date) {
        self = date
    }
    
    func toString() -> String {
        return Date.formatterOut.string(from: self)
    }
    func toStringWithYear() -> String {
        return Date.formatterOutWithYear.string(from: self)
    }
}

