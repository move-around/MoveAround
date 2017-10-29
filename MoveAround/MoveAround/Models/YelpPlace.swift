//
//  YelpPlace.swift
//  MoveAround
//
//
//  Created by Ngan, Naomi on 10/13/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.

import UIKit

class YelpPlace: Place {

    init(dictionary: NSDictionary) {
        super.init()
        name = dictionary["name"] as? String
        
        var imageURLString = dictionary["image_url"] as? String
        if imageURLString != nil {
            imageURLString = imageURLString?.replacingOccurrences(of: "ms.jpg", with: "l.jpg")
            imageURL = URL(string: imageURLString!)!
        } else {
            imageURL = nil
        }
        
        phoneNumber = dictionary["phone"] as? String
        
        
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil {
            if let coordinates = location!["coordinate"] as? [String:Double] {
                self.longitude = coordinates["longitude"]
                self.latitude = coordinates["latitude"]
                self.positionVector = Vector([self.latitude!, self.longitude!])
            }
            let addressArray = location!["address"] as? NSArray
            if addressArray != nil && addressArray!.count > 0 {
                address = addressArray![0] as! String
            }
            
            let neighborhoods = location!["neighborhoods"] as? NSArray
            if neighborhoods != nil && neighborhoods!.count > 0 {
                if !address.isEmpty {
                    address += ", "
                }
                address += neighborhoods![0] as! String
            }
        }
        self.address = address
        
        let categoriesArray = dictionary["categories"] as? [[String]]
        if categoriesArray != nil {
            var categoryNames = [String]()
            var internalCategoryNames = [String]()
            for category in categoriesArray! {
                let categoryName = category[0]
                let internalCategoryName = category[1]
                categoryNames.append(categoryName)
                internalCategoryNames.append(internalCategoryName)
            }
            categories = categoryNames.joined(separator: ", ")
            internalCategories = internalCategoryNames.joined(separator: ",")
            print("Categories for \(name!) = \(categories!)")
            print("Internal Categories for \(name!) = \(internalCategories!)")
        } else {
            categories = nil
        }
        
        let distanceMeters = dictionary["distance"] as? NSNumber
        if distanceMeters != nil {
            let milesPerMeter = 0.000621371
            distance = String(format: "%.2f mi", milesPerMeter * distanceMeters!.doubleValue)
        } else {
            distance = nil
        }
        
        let ratingImageURLString = dictionary["rating_img_url_large"] as? String
        if ratingImageURLString != nil {
            ratingImageURL = URL(string: ratingImageURLString!)
        } else {
            ratingImageURL = nil
        }
        
        let resUrl = dictionary["reservation_url"] as? String
        if resUrl != nil {
            reservationURL = resUrl
        }
        
        let mobileUrl = dictionary["mobile_url"] as? String
        if mobileUrl != nil {
            url = mobileUrl
        }
        
        reviewCount = dictionary["review_count"] as? NSNumber
        
        id = dictionary["id"] as? String
    }
    
    class func places(array: [NSDictionary]) -> [YelpPlace] {
        var places = [YelpPlace]()
        for dictionary in array {
            let place = YelpPlace(dictionary: dictionary)
            places.append(place)
        }
        return places
    }
    
//    class func searchWithId(id: String, completion: @escaping ([Place]?, Error?) -> Void) {
//        _ = YelpClient.sharedInstance.searchWithId(id, completion: completion)
//    }
//    
    
  class func searchWithTerm(term: String, offset: Int, completion: @escaping ([Place]?, Error?) -> Void) {
    _ = YelpClient.sharedInstance.searchWithTerm(term, offset: offset, completion: completion)
    }
    
    class func searchWithTerm(term: String?, location: String?, sort: YelpSortMode?, categories: [String]?, deals: Bool?, radius: Float?, limit: Int?, offset: Int?, completion: @escaping ([Place]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, location: location, sort: sort, categories: categories, deals: deals, radius: radius, limit: limit, offset: offset, completion: completion)
    }
    

}
