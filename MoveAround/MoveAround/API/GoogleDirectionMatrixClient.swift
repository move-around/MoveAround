//
//  GoogleDirectionMatrixClient.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/22/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class GoogleDirectionMatrixClient: NSObject {

    func getWalkingDistance(from: Place, to: Place, onDataLoad:@escaping (_ walkTime: String)->Void) {
        // Get the data from Google distance API
        let urlString = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=\(from.latitude!),\(from.longitude!)&destinations=\(to.latitude!),\(to.longitude!)&mode=walking"
        let url = URL(string:urlString)
        var request = URLRequest(url: url!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request, completionHandler:
        { (dataOrNil, response, error) in
            if let data = dataOrNil {
                
                let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let walkTime = ((((dictionary["rows"] as! [[String:Any]])[0]["elements"]) as! [[String:Any]])[0]["duration"] as! [String:Any])["text"] as! String
                onDataLoad(walkTime);
            }
            else if (error != nil) {
                // Show the network error view
            }
        });
        task.resume()
    }

}
