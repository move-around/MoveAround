//
//  GooglePlacesClient.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 11/11/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import Foundation
import AFNetworking

class GooglePlacesClient {
    static let apiKey = "AIzaSyCvt5DdJ64JGgx0W44CFynbK0EHcUUHq6c"
    
    static func getPhotoUrl(_ placeId: String!, completion: @escaping (_ photoUrl: String?) -> Void) {
        let baseUrl = "https://maps.googleapis.com/maps/api/place"

        let baseUrlString = "\(baseUrl)/details/json?"
        
        let queryString = "placeid=\(placeId!)&key=\(apiKey)"
        let url = URL(string: baseUrlString + queryString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let request = URLRequest(url: url)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate:nil, delegateQueue:OperationQueue.main)
        
        let task : URLSessionDataTask = session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
            var photoUrl:String?
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    let resultPhotos = responseDictionary.value(forKeyPath: "result.photos") as? [[String:Any]]
                    if let photos = resultPhotos {
                        let photo = photos[0]
                        if let photoRef = photo["photo_reference"] as? String {
                            photoUrl = "\(baseUrl)/photo?maxheight=200&photoreference=\(photoRef)&key=\(apiKey)"
                        }
                        
                    }
                }
            }
            completion(photoUrl)
        });
        task.resume()
    }

    
}
