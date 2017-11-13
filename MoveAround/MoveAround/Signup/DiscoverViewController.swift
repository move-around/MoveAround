//
//  DiscoverViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 11/9/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import CalendarDateRangePickerViewController

class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var manualImage: UIImageView!
    @IBOutlet weak var quickImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let archetypeArray =
        [Archetype(name: "Foodie", imageName: "foodie", description: "Interested in food and beverages.  Seeks new food experiences as a hobby.", itineraryName: "foodieItinerary"),
         Archetype(name: "Party Animal", imageName: "nightowl", description: "Likes to Party. Participates in noctural activities.", itineraryName: "partyItinerary"),
         Archetype(name: "Adventurer", imageName: "adventurer", description: "Engages in adventures and active exercises.", itineraryName: "adventurerItinerary"),
         Archetype(name: "Touristy", imageName: "touristy", description: "Enjoys attractions of cultural value or historical significance.", itineraryName: "touristItinerary"),
         Archetype(name: "Unique", imageName: "unique", description: "Finds leisure in off the beaten path experiences.", itineraryName: "uniqueItinerary"),
         Archetype(name: "Artistic", imageName: "artsy", description: "Enthusiastic about the arts.  Enjoys cultural exhibitions.", itineraryName: "artsyItinerary"),
         Archetype(name: "Thrifty", imageName: "budget", description: "Travelling on a budget and looking for deals.", itineraryName: "thriftyItinerary")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        manualImage.tintColorDidChange()
        quickImage.tintColorDidChange()
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapEdit(recognizer:)))
        tableView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return archetypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArchetypeCell") as! ArchetypeCell
        let archetype = archetypeArray[indexPath.row]
        cell.nameLabel.text = archetype.name
        cell.posterImage.image = UIImage(named: archetype.imageName)
        cell.descriptionLabel.text = archetype.description
        return cell
    }

    // MARK: - TapGestureRecognizer
    @objc func tapEdit(recognizer: UITapGestureRecognizer)  {
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                let currentItinerary = Itinerary.currentItinerary
                let itineraryArchetype = archetypeArray[tapIndexPath.row].itineraryName
                let itineraryDestination = currentItinerary.destination!
                if let itineraryData = ItineraryData.itineraryList[itineraryDestination]?[itineraryArchetype!] {
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
        }
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

extension DiscoverViewController : CalendarDateRangePickerViewControllerDelegate {
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

