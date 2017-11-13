//
//  QuickViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 11/9/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import CHPulseButton
import CalendarDateRangePickerViewController

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

    @IBAction func onTap(_ sender: Any) {
        
        // Pre load an archetype itinerary
        let currentItinerary = Itinerary.currentItinerary
        // TODO(Mohit): Change this for the demo
        let itineraryArchetype = "touristItinerary"
        let itineraryDestination = currentItinerary.destination!
        if let itineraryData = ItineraryData.itineraryList[itineraryDestination]?[itineraryArchetype] {
            currentItinerary.dayItineraries = Itinerary.loadItinerary(itineraryData: itineraryData).dayItineraries
            
            // Also show the date picker right away
            let dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
            dateRangePickerViewController.delegate = self
            dateRangePickerViewController.minimumDate = Date()
            dateRangePickerViewController.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())
            let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QuickViewController : CalendarDateRangePickerViewControllerDelegate {
    func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didTapDoneWithDateRange(startDate: Date!, endDate: Date!) {
        
        self.dismiss(animated: true, completion: nil)
        let itinerary = Itinerary.currentItinerary
        itinerary.startDate = startDate
        itinerary.endDate = endDate
        
        let itineraryStoryboard = UIStoryboard(name: "Itinerary", bundle: nil)
        
        let itineraryLoadingView = itineraryStoryboard.instantiateViewController(withIdentifier: "loadingScreenViewController")
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.rootViewController = itineraryLoadingView
        
    }
    
}
