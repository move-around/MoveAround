//
//  LoadingScreenViewController.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/29/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import DotsLoading

class LoadingScreenViewController: UIViewController {

    @IBOutlet weak var loadingView: UIView!
    var exitLoadingScreenTimer: Timer!
    var itineraryData: [[[String]]]? = nil
    let dotColors = [UIColor(hex: "FF7112"), UIColor(hex: "FF6012"), UIColor(hex: "FF4912"), UIColor(hex: "FF3612")]
    let dotsView: DotsLoadingView! = DotsLoadingView(colors: [UIColor(hex: "FF7112"), UIColor(hex: "FF6012"), UIColor(hex: "FF4912"), UIColor(hex: "FF3612")])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingView.addSubview(dotsView)
        dotsView.show()
        
//        exitLoadingScreenTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(exitLoadingScreen), userInfo: nil, repeats: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        if let itineraryData = self.itineraryData {
            let itinerary = Itinerary.currentItinerary
            itinerary.dayItineraries = Itinerary.loadItinerary(itineraryData: itineraryData).dayItineraries
        }
        
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "loadingFinishedSegue", sender: nil)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func exitLoadingScreen() {
        performSegue(withIdentifier: "loadingFinishedSegue", sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
