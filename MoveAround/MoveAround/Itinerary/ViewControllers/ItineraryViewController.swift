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
    @IBOutlet weak var prevDayButton: UIBarButtonItem!
    @IBOutlet weak var nextDayButton: UIBarButtonItem!
    @IBOutlet weak var mapImageView: UIImageView!
    
    
    var initialTimeSlots: [[String]] = [["9:00 AM", "10:00 AM"],
                                        ["10:30 AM", "1:00 PM"],
                                        ["1:30 PM", "2:30 PM"],
                                        ["3:00 PM", "4:30 PM"],
                                        ["5:00 PM", "7:00 PM"],
                                        ["7:30 PM", "9:00 PM"],
                                        ["9:30 PM", "11:00 PM"]]
    
    var dayItinerary: DayItinerary?
    var currentDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Table View data source
        tableView.dataSource = self
        tableView.delegate = self

        let currentItinerary = Itinerary.currentItinerary

        if let startDate = currentItinerary.startDate {
            let startDateStr = startDate.toStringWithYear()
            self.dayLabel.title = startDateStr
            self.prevDayButton.isEnabled = false
            self.prevDayButton.title = ""
            self.nextDayButton.isEnabled = false
            self.nextDayButton.title = ""
            // Check if the itinarary is for more than a single day
            if (currentItinerary.startDate! < currentItinerary.endDate!) {
                let dateInterval = DateInterval.init(start: currentItinerary.startDate!, end: currentItinerary.endDate!)
                let durationInDays = Int(round(dateInterval.duration/86400)) + 1
                if (durationInDays > 1) {
                    self.nextDayButton.title = ">"
                    nextDayButton.isEnabled = true
                }
            }
            currentDate = startDate
        }
        if (currentItinerary.dayItineraries[0] == nil) {
            dayItinerary = DayItinerary()
            currentItinerary.dayItineraries[0] = dayItinerary
        }
        else {
            dayItinerary = currentItinerary.dayItineraries[0]
        }



        // Set Tab bar item title
        self.navigationController?.tabBarItem.title = "Itinerary"
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapEdit(recognizer:)))
        tableView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self

        tableView.reloadSections(IndexSet(integer: 0) , with: UITableViewRowAnimation.fade)

        mapImageView.makeCircular()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prevDayButton.isEnabled = true
        prevDayButton.title = "<"
        
        nextDayButton.isEnabled = true
        nextDayButton.title = ">"
        
        dayLabel.title = currentDate?.toStringWithYear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.dayLabel.title = ""
    }
    

    @IBAction func loadPreviousDayItinerary(_ sender: UIBarButtonItem) {
        // Fix the date for current date label and previous/next buttons
        let currentItinerary = Itinerary.currentItinerary

        nextDayButton.title = ">"
        nextDayButton.isEnabled = true
        
        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate!)
        dayLabel.title = currentDate?.toStringWithYear()
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate!)
        if (yesterday! < currentItinerary.startDate!) {
            prevDayButton.isEnabled = false
            prevDayButton.title = ""
        }
        else {
            prevDayButton.title = "<"
        }
        reloadDayItinerary()
    }
    
    
    @IBAction func loadNextDayItinerary(_ sender: UIBarButtonItem) {
        // Fix the date for current date label and previous/next buttons
        let currentItinerary = Itinerary.currentItinerary

        prevDayButton.title = "<"
        prevDayButton.isEnabled = true
        
        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate!)
        dayLabel.title = currentDate?.toStringWithYear()
        
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentDate!)
        let itineraryEndDateForComparison = Calendar.current.date(byAdding: .hour, value: 1, to: currentItinerary.endDate!)
        if (tomorrow! > itineraryEndDateForComparison!) {
            nextDayButton.isEnabled = false
            nextDayButton.title = ""
        }
        else {
            nextDayButton.title = ">"
        }
        reloadDayItinerary()
    }
    
    func reloadDayItinerary () {
        // Reload the Day itinerary and reload table
        let currentItinerary = Itinerary.currentItinerary
        let dateInterval = DateInterval.init(start: currentItinerary.startDate!, end: currentDate!)
        let dayIndex = Int(round(dateInterval.duration/86400))
        if (currentItinerary.dayItineraries[dayIndex] == nil) {
            dayItinerary = DayItinerary()
            currentItinerary.dayItineraries[dayIndex] = dayItinerary
        }
        else {
            dayItinerary = currentItinerary.dayItineraries[dayIndex]
        }
        //tableView.reloadData()
        tableView.reloadSections(IndexSet(integer: 0) , with: UITableViewRowAnimation.fade)
    }
    
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return initialTimeSlots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryTableViewCell", for: indexPath) as! ItineraryTableViewCell
        // TODO (mohit) : Set the place itinerary data structure here properly
        cell.timePeriodLabel.text = initialTimeSlots[indexPath.row][0] + " to " + initialTimeSlots[indexPath.row][1]
        if (dayItinerary?.placesItineraries[indexPath.row] != nil && dayItinerary?.placesItineraries[indexPath.row]?.place != nil) {
            cell.place = dayItinerary?.placesItineraries[indexPath.row]?.place
        } else {
            cell.resetCell()
        }
        cell.delegate = self
        
        return cell
    }
    
    func showSelectedPlaces(cell: UITableViewCell) {
        performSegue(withIdentifier: "showPlaces", sender: cell)
    }
    
    func placeSelected(placeItinerary: PlaceItinerary, cell: UITableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        if (dayItinerary?.placesItineraries[(indexPath?.row)!] == nil) {
            dayItinerary?.placesItineraries[(indexPath?.row)!] = PlaceItinerary()
        }
        dayItinerary?.placesItineraries[(indexPath?.row)!]?.place = placeItinerary.place
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
            var plannedPlacesForDay: [Place] = [Place]()
            for pItinerary in (dayItinerary?.placesItineraries)! {
                if (pItinerary != nil) && (pItinerary!.place != nil) {
                    plannedPlacesForDay.append(pItinerary!.place!)
                }
            }
            vc.places = plannedPlacesForDay
            
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

    @IBAction func showMap(_ sender: Any) {
        performSegue(withIdentifier: "showItineraryMap", sender: nil)
    }
    
}
