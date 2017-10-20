//
//  InterestSelectionViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/20/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class InterestSelectionViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    var viewCategory = ViewCategory()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView?.allowsMultipleSelection = true
        tableView?.dataSource = viewCategory
        tableView?.delegate = self
        
        nextButton?.isEnabled = !viewCategory.selectedItems.isEmpty
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // Set zero height table footer to not show cells beyond those asked for
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onNextTapped(_ sender: UIButton) {
        print(viewCategory.selectedItems.map{$0.name})
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewCategory.items[indexPath.row].isSelected = true
        nextButton?.isEnabled = !viewCategory.selectedItems.isEmpty

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewCategory.items[indexPath.row].isSelected = false
        nextButton?.isEnabled = !viewCategory.selectedItems.isEmpty

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
