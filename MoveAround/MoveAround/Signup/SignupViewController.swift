//
//  SignupViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/15/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import GooglePlaces
import CalendarDateRangePickerViewController

class SignupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var horizontalLineTop: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    var tableData=[String]()
    var fetcher: GMSAutocompleteFetcher?
    var startDate: Date!
    var endDate: Date!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentUser = User.currentUser {
            greeting.text = "Hi \(currentUser.firstName!)!"
        }
        let neBoundsCorner = CLLocationCoordinate2D(latitude: -33.843366,
                                                    longitude: 151.134002)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: -33.875725,
                                                    longitude: 151.200349)
        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner,
                                         coordinate: swBoundsCorner)
        
        // Set up the autocomplete filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        
        // Create the fetcher.
        fetcher = GMSAutocompleteFetcher(bounds: bounds, filter: filter)
        fetcher?.delegate = self
        textField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 1.0
        tableView.tableFooterView = UIView()


        nextButton.isEnabled = false
    }

    
    @IBAction func didTapButton(_ sender: UIButton) {
        let dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        dateRangePickerViewController.delegate = self
        dateRangePickerViewController.minimumDate = Date()
        dateRangePickerViewController.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())
        dateRangePickerViewController.selectedStartDate = Date()
        dateRangePickerViewController.selectedEndDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())
        let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        fetcher?.sourceTextHasChanged(textField.text!)
        tableView.isHidden = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData.count != 0 {
            self.view.sendSubview(toBack: horizontalLineTop)
            dateButton.isHidden = true
            tableView.isHidden = false
        } else {
            self.view.bringSubview(toFront: horizontalLineTop)
            dateButton.isHidden = false
            tableView.isHidden = true
        }
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textField.text = tableData[indexPath.row]
        dateButton.isHidden = false
        tableView.isHidden = true
        view.endEditing(true)
        nextButton.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"addCategoryCell")
        
        cell.selectionStyle =  UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.textLabel?.textColor = UIColor.gray
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        
        cell.textLabel?.text = tableData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! InterestSelectionViewController
        let itinerary = Itinerary.currentItinerary
        itinerary.destination = textField.text
        itinerary.startDate = startDate
        itinerary.endDate = endDate
        
        // Calculate number of days for the trip
        var durationInDays = 1
        if (itinerary.startDate! < itinerary.endDate!) {
            let dateInterval = DateInterval.init(start: itinerary.startDate!, end: itinerary.endDate!)
            durationInDays = Int(round(dateInterval.duration/86400)) + 1
        }
        itinerary.dayItineraries = [DayItinerary?](repeating: nil, count: durationInDays)

        vc.itinerary = itinerary
    }

}

extension SignupViewController : CalendarDateRangePickerViewControllerDelegate {
    func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didTapDoneWithDateRange(startDate: Date!, endDate: Date!) {
        self.startDate = startDate
        self.endDate = endDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        label.text = dateFormatter.string(from: startDate) + " - " + dateFormatter.string(from: endDate)
        
        self.dismiss(animated: true, completion: nil)
    }

}

extension SignupViewController: GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        tableData.removeAll()
        
        for prediction in predictions {
            tableData.append(prediction.attributedFullText.string)
//
//            print("\n",prediction.attributedFullText.string)
//            print("\n",prediction.attributedPrimaryText.string)
//            print("\n********")
        }
        
        tableView.reloadData()
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        //resultText?.text = error.localizedDescription
        print(error.localizedDescription)
    }
}
