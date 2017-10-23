//
//  ItineraryMapViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/22/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class ItineraryMapViewController: UIViewController {

    @IBOutlet weak var mapView: MapView!
    var places: [Place] = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.places = places
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
