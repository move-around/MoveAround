//
//  String.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/19/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import Foundation

extension String {
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}
