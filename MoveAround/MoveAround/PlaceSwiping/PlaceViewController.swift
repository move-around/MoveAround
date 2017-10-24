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
    @IBOutlet weak var doneButton: UIButton!
    
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
        let itineraryStoryboard = UIStoryboard(name: "Itinerary", bundle: nil)
        
        let itineraryNavigationController = itineraryStoryboard.instantiateViewController(withIdentifier: "ItineraryNavigationController") as! UINavigationController
        //itineraryNavigationController.tabBarItem.title = "Itinerary"
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.rootViewController = itineraryNavigationController

        /*
        self.navigationController?.tabBarItem.title = "Explore"
        //self.navigationController?.tabBarItem.image = UIImage(named: "itinerary")

        doneButton.isHidden = true
        
        // Create the TabBarController here itself and set it as the root view controller
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(white: 1, alpha: 1)
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.rootViewController = tabBarController
        tabBarController.viewControllers = [self.navigationController!, itineraryNavigationController]
        tabBarController.selectedViewController = itineraryNavigationController
         */
        
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
