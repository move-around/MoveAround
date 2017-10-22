//
//  PlaceViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/14/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var placeImageView: PlaceSwipeableSuperView!
    fileprivate let segueToDetail = "showDetailPage"
    fileprivate let segueToItinerary = "showListOfPlaces"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onPlaceTapped(_ sender: UITapGestureRecognizer) {
        let place = placeImageView.loadedViews.first?.place
        performSegue(withIdentifier: segueToDetail, sender: place)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToDetail {
            let vc = segue.destination as! PlaceDetailViewController
            vc.transitioningDelegate = self
            vc.place = sender as! Place
        } else if segue.identifier == segueToItinerary {
            // Do something special here if required
        }

    }

    @IBAction func onYesTapped(_ sender: UITapGestureRecognizer) {
        placeImageView.clickedRight()
        
    }
    
    @IBAction func onNoTapped(_ sender: UITapGestureRecognizer) {
        placeImageView.clickedLeft()
    }
    
    @IBAction func onDonePressed(_ sender: Any) {
        performSegue(withIdentifier: segueToItinerary, sender: nil)
    }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransition()
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

// Not ideal, but waiting for user login/persistance stuff to be finished.  Maybe use NotificationCenter
class TempCache{
    static let sharedInstance = TempCache()
    
    var itinerary: Itinerary?

    init() {
    }
    
}
