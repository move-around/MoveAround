//
//  PhotoAnnotation.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/27/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//
import UIKit
import MapKit

class PhotoAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var photo: UIImage!
    var pinTitle: String!
    var index: Int!
    
    var title: String? {
        return pinTitle
    }
}
