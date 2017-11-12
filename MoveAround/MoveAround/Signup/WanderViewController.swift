//
//  WanderViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 11/9/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class WanderViewController: UIViewController {

    @IBOutlet weak var quickImage: UIImageView!
    fileprivate let segueToDetail = "showDetailPage"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        quickImage.tintColorDidChange()

    }

    override func becomeFirstResponder() -> Bool {
        return true
    }

    @IBAction func onScreenTap(_ sender: UITapGestureRecognizer) {
        findPlace()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            findPlace()
        }
    }
    
    func findPlace() {
        // To keep things simple, just randomize a bunch of params
        let viewCategory = ViewCategory()
        let offsetNumber = Int(arc4random_uniform(20))
        let categoryNumber = Int(arc4random_uniform((UInt32(viewCategory.items.count-1))))
        let sort = YelpSortMode(rawValue: Int(arc4random_uniform(2)))
        let category = (viewCategory.items[categoryNumber]).yelpCode
        let location = Itinerary.currentItinerary.destination
        
        // Perform request to Yelp API to get the list of places
        YelpPlace.searchWithTerm(term: nil, location: location, sort: sort, categories: [category], deals: false, radius: nil, limit:  1, offset: offsetNumber) { (places: [Place]?, error: Error?) in
            if let places = places {
                self.performSegue(withIdentifier: self.segueToDetail, sender: places.first)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToDetail {
            let vc = segue.destination as! PlaceDetailViewController
            vc.place = sender as! Place
            vc.wasShook = true
        }
    }
}
