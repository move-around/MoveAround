//
//  ItineraryViewController.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/20/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class ItineraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ItineraryTableViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var dayLabel: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!

    //TODO: Gonzalo
    @IBAction func onSaveTap(_ sender: UIBarButtonItem) {
        // Adding the "save" alert code here here temporarily until the
        // other stuff is ready. The persistance code needs to know about this.
        
        let alert = UIAlertController(title: "Awesome!", message: "Your itinerary has been saved.", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)

    }
    
    var initialTimeSlots: [[String]] = [["9:00 AM", "10:00 AM"],
                                        ["10:30 AM", "1:00 PM"],
                                        ["1:30 PM", "2:30 PM"],
                                        ["3:00 PM", "4:30 PM"],
                                        ["5:00 PM", "7:00 PM"],
                                        ["7:30 PM", "9:00 PM"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Table View data source
        tableView.dataSource = self
        tableView.delegate = self

        let current = Itinerary.currentItinerary
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"

        if let startDate = current.startDate {
            let startDateStr = dateFormatterPrint.string(from: startDate)
            self.dayLabel.title = "\(startDateStr) trip to \(current.destination!)"
        }


        // Set Tab bar item title
        self.navigationController?.tabBarItem.title = "Itinerary"
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapEdit(recognizer:)))
        tableView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return initialTimeSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryTableViewCell", for: indexPath) as! ItineraryTableViewCell
        // TODO (mohit) : Set the place itinerary data structure here properly
        cell.timePeriodLabel.text = initialTimeSlots[indexPath.row][0] + " to " + initialTimeSlots[indexPath.row][1]
        cell.delegate = self
        
        return cell
    }
    
    func showSelectedPlaces(cell: UITableViewCell) {
        performSegue(withIdentifier: "showPlaces", sender: cell)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showPlaces" {
            let vc = segue.destination as! PlacesListViewController
            vc.isShowingSelectedPlaces = true
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            vc.cellRowForItineraryView = indexPath?.row
        } else if segue.identifier == "showItineraryMap" {
            let vc = segue.destination as! ItineraryMapViewController
            vc.places = Itinerary.currentItinerary.plannedPlaces
            
        }
        else if segue.identifier == "showDetail" {
            let indexPath = sender as! IndexPath
            let cell = tableView.cellForRow(at: indexPath) as! ItineraryTableViewCell
            let vc = segue.destination as! PlaceDetailViewController
            vc.place = cell.place
        }

    }
    
    // MARK: - TapGestureRecognizer
    @objc func tapEdit(recognizer: UITapGestureRecognizer)  {
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                performSegue(withIdentifier: "showDetail", sender: tapIndexPath)
            }
        }
    }


}
