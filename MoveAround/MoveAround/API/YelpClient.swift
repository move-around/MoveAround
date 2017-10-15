//
//  YelpClient.swift
//  Yelp
//

import UIKit
	
import AFNetworking
import BDBOAuth1Manager

// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"

enum YelpSortMode: Int {
  case bestMatched = 0, distance, highestRated
}

class YelpClient: BDBOAuth1RequestOperationManager {
  var accessToken: String!
  var accessSecret: String!
  
  //MARK: Shared Instance
  
  static let sharedInstance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
    self.accessToken = accessToken
    self.accessSecret = accessSecret
    let baseUrl = URL(string: "https://api.yelp.com/v2/")
    super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
    
    let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
    self.requestSerializer.saveAccessToken(token)
  }
  
  func searchWithTerm(_ term: String, completion: @escaping ([Place]?, Error?) -> Void) -> AFHTTPRequestOperation {
    return searchWithTerm(term, location: nil, sort: nil, categories: nil, deals: nil, radius: nil, limit: nil, offset: nil, completion: completion)
  }
  
    func searchWithTerm(_ term: String?, location: String?, sort: YelpSortMode?, categories: [String]?, deals: Bool?, radius: Float?, limit: Int?, offset: Int?, completion: @escaping ([Place]?, Error?) -> Void) -> AFHTTPRequestOperation {
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    
    var parameters: [String : AnyObject] = [String :AnyObject]()

    if term != nil {
        parameters["term"] = term as AnyObject
    }
        
    if location != nil {
        parameters["location"] = location as AnyObject
    }

    if sort != nil {
      parameters["sort"] = sort!.rawValue as AnyObject?
    }
    
    if categories != nil && categories!.count > 0 {
      parameters["category_filter"] = (categories!).joined(separator: ",") as AnyObject?
    }
    
    if deals != nil {
      parameters["deals_filter"] = deals! as AnyObject?
    }
    
    if radius != nil && radius! > 0 {
      parameters["radius_filter"] = radius! as NSNumber?
    }
    
    if limit != nil {
      parameters["limit"] = limit! as NSNumber?
    }
    
    if offset != nil {
      parameters["offset"] = offset! as NSNumber?
    }
    
    print(parameters)
    
    return self.get("search", parameters: parameters,
                    success: { (operation: AFHTTPRequestOperation, response: Any) -> Void in
                      if let response = response as? [String: Any]{
                        let dictionaries = response["businesses"] as? [NSDictionary]
                        if dictionaries != nil {
                          completion(YelpPlace.places(array: dictionaries!), nil)
                        }
                      }
                    },
                    failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                        print(error)
                      completion(nil, error)
                    })!
  }
}

