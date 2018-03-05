//
//  YelpClient.swift
//  Yelp
//

import UIKit
import Alamofire

let yelpAPIKey = "vt-PqUb8fPEZv5CTM506vXETrLfNhupiEM8w2-qctjvlp5sboYZlki9sWXwu2l-WFBby57zlyc_58xnfwu1lk8RbGnlXi2I262wZaIrewDtkeWfM5uCD2FsUnH3xWXYx"
let baseUrl = URL(string: "https://api.yelp.com/v3/")

enum YelpSortMode: String {
    case best_match, distance, rating, review_count
}

class YelpClient {
    var apiKey: String!
    var headers: HTTPHeaders!

    static let sharedInstance = YelpClient(apiKey: yelpAPIKey)
    
    init(apiKey key: String!) {
        self.apiKey = key
        self.headers = ["Authorization": "Bearer \(key!)"]
    }
    
    func searchWithTerm(_ term: String, offset: Int, completion: @escaping ([Place]?, Error?) -> Void) {
        return searchWithTerm(term, location: nil, sort: nil, categories: nil, deals: nil, radius: nil, limit: nil, offset: offset, completion: completion)
    }
    
    func searchWithTerm(_ term: String?, location: String?, sort: YelpSortMode?, categories: [String]?, deals: Bool?, radius: Float?, limit: Int?, offset: Int?, completion: @escaping ([Place]?, Error?) -> Void) {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        var parameters: [String : AnyObject] = [String :AnyObject]()
        
        if term != nil {
            parameters["term"] = term as AnyObject
        }
        
        if location != nil {
            parameters["location"] = location as AnyObject
        } else {
            parameters["location"] = (Itinerary.currentItinerary.destination ?? "San Francisco") as AnyObject
        }
        
        if sort != nil {
            parameters["sort_by"] = sort!.rawValue as AnyObject?
        }

        if categories != nil && categories!.count > 0 {
            parameters["categories"] = (categories!).joined(separator: ",") as AnyObject?
        }

        if deals != nil && deals! {
            parameters["attributes"] = "deals" as AnyObject
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
        
        let apiUrl = baseUrl?.appendingPathComponent("businesses/search")
        
        Alamofire.request(apiUrl!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: self.headers).responseJSON { (response) in
            if let error = response.result.error {
                print(error)
                completion(nil, error)
            }
            if let response = response.result.value as? [String: Any]{
                print(response)
                let dictionaries = response["businesses"] as? [NSDictionary]
                if dictionaries != nil {
                    completion(YelpPlace.places(array: dictionaries!), nil)
                }
            }
        }

    }


    func getBusinessForId(id: String, completion: @escaping (Place?, Error?) -> Void) {
        print("inside getBusinessForId: \(id)")
        sleep(1) // Temporarily here to deal with Yelp throttling
        let apiUrl = baseUrl?.appendingPathComponent("businesses/\(id)")
        Alamofire.request(apiUrl!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: self.headers).responseJSON { (response) in
            if let error = response.result.error {
                print(error)
                completion(nil, error)
            }
            if let response = response.result.value as? NSDictionary {
                print(response)
                completion(YelpPlace(dictionary: response), nil)
            }
        }

    }
    
}

