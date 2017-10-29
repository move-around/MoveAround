//
//  LocationsViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/28/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

// So that LocationViewController can communicate back to PhotoMapViewController the location selected
protocol LocationsViewControllerDelegate : class {
    func locationsPickedLocation(controller: LocationsViewController, index: Int)
}

class LocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate : LocationsViewControllerDelegate!

    var annotations: [PhotoAnnotation] = [PhotoAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        cell.nameLabel.text = annotations[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Call the delegate method with the location the user selects
        delegate.locationsPickedLocation(controller: self, index: indexPath.row)
        
    }
}
