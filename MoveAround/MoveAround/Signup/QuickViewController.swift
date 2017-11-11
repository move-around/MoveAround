//
//  QuickViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 11/9/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import CHPulseButton

class QuickViewController: UIViewController {

    @IBOutlet weak var roundButton: CHPulseButton!
    @IBOutlet weak var discoverImage: UIImageView!
    @IBOutlet weak var wanderImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        roundButton.animate(start: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        discoverImage.tintColorDidChange()
        wanderImage.tintColorDidChange()

    }
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
//        Itinerary.currentItinerary.generateItinerary()
        
        let itineraryStoryboard = UIStoryboard(name: "Itinerary", bundle: nil)
        
        let itineraryLoadingView = itineraryStoryboard.instantiateViewController(withIdentifier: "loadingScreenViewController")
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.rootViewController = itineraryLoadingView
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
