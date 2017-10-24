//
//  SignupViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/15/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import GooglePlaces

class SignupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var tableData=[String]()
    var fetcher: GMSAutocompleteFetcher?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let neBoundsCorner = CLLocationCoordinate2D(latitude: -33.843366,
                                                    longitude: 151.134002)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: -33.875725,
                                                    longitude: 151.200349)
        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner,
                                         coordinate: swBoundsCorner)
        
        // Set up the autocomplete filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        filter.country = "us"
        
        // Create the fetcher.
        fetcher = GMSAutocompleteFetcher(bounds: bounds, filter: filter)
        fetcher?.delegate = self
        textField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
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
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableData[indexPath.row])
        textField.text = tableData[indexPath.row]
        tableView.isHidden = true
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"addCategoryCell")
        
        cell.selectionStyle =  UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        
        cell.textLabel?.text = tableData[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! InterestSelectionViewController
        let itinerary = Itinerary.currentItinerary
        itinerary.destination = textField.text
        itinerary.startDate = datePicker.date
        itinerary.endDate = Calendar.current.date(byAdding: .day, value: 3, to: datePicker.date)
        itinerary.dayItineraries = [DayItinerary?](repeating: nil, count: 4)

        vc.itinerary = itinerary
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
