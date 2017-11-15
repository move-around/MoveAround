//
//  PlaceViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/14/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import CalendarDateRangePickerViewController



class PlaceViewController: UIViewController, UIViewControllerTransitioningDelegate, PlaceSwipeableSuperViewDelegate {
    @IBOutlet weak var placeImageView: PlaceSwipeableSuperView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var yesImage: UIImageView!
    var startDate: Date!
    var endDate: Date!

    
    fileprivate let segueToDetail = "showDetailPage"
    fileprivate let segueToItinerary = "showListOfPlaces"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        placeImageView.delegate = self
        yesImage.tintColorDidChange()

    }

    @IBAction func onInfoTapped(_ sender: UITapGestureRecognizer) {
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
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            backItem.tintColor = UIColor.init(red: 255/255, green: 113/255, blue: 18/255, alpha: 1)
        } else if segue.identifier == segueToItinerary {
            // Do something special here if required
        }

    }
    
    func clickedImage() {
        let place = placeImageView.loadedViews.first?.place
        performSegue(withIdentifier: segueToDetail, sender: place)
    }


    @IBAction func onYesTapped(_ sender: UITapGestureRecognizer) {
        placeImageView.clickedRight()
    }
    
    @IBAction func onNoTapped(_ sender: UITapGestureRecognizer) {
        placeImageView.clickedLeft()
    }
    
    @IBAction func onDonePressed(_ sender: Any) {
        // Add the non swiped but interesting places to the itinerary
        let currentPlace = placeImageView.loadedViews.first?.place
        let listOfRemainingPlaces = placeImageView.places[placeImageView.places.index(of: currentPlace!)!...]
        Itinerary.currentItinerary.unswipedInterestingPlaces.append(contentsOf: listOfRemainingPlaces)

        let dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        dateRangePickerViewController.delegate = self
        dateRangePickerViewController.minimumDate = Date()
        dateRangePickerViewController.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())
        //        dateRangePickerViewController.selectedStartDate = Date()
        //        dateRangePickerViewController.selectedEndDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())
        let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
        self.present(navigationController, animated: true, completion: nil)
        
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

extension PlaceViewController : CalendarDateRangePickerViewControllerDelegate {
    func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didTapDoneWithDateRange(startDate: Date!, endDate: Date!) {
        self.startDate = startDate
        self.endDate = endDate
        
        self.dismiss(animated: true, completion: nil)
        let itinerary = Itinerary.currentItinerary
        itinerary.startDate = startDate
        itinerary.endDate = endDate
        
        // Calculate number of days for the trip
        var durationInDays = 1
        if (itinerary.startDate! < itinerary.endDate!) {
            let dateInterval = DateInterval.init(start: itinerary.startDate!, end: itinerary.endDate!)
            durationInDays = Int(round(dateInterval.duration/86400)) + 1
        }
        itinerary.dayItineraries = [DayItinerary?](repeating: nil, count: durationInDays)
        
        Itinerary.currentItinerary = itinerary
        
        if let itineraryData = ItineraryData.itineraryList[itinerary.destination!]!["touristItinerary"] {
            itinerary.dayItineraries = Itinerary.loadItinerary(itineraryData: itineraryData).dayItineraries
        } else {
            ItineraryCreator.generateItinerary(itinerary: Itinerary.currentItinerary)
        }

        
        let itineraryStoryboard = UIStoryboard(name: "Itinerary", bundle: nil)
        
        let itineraryLoadingView = itineraryStoryboard.instantiateViewController(withIdentifier: "loadingScreenViewController")
        //itineraryNavigationController.tabBarItem.title = "Itinerary"
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.rootViewController = itineraryLoadingView

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
    
}

// Not ideal, but waiting for user login/persistance stuff to be finished.  Maybe use NotificationCenter
class TempCache{
    static let sharedInstance = TempCache()
    
    var itinerary: Itinerary?

    init() {
    }
    
}
