//
//  ViewCategory.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/20/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//
import Foundation
import UIKit

class ViewCategory: NSObject {
    var items = [CategoryItem]()
    var selectedItems: [CategoryItem] {
        return items.filter {return $0.isSelected}
    }
    
    let categoryArray =
        [Category(name: "Art Galleries", yelpCode: "galleries"),
         Category(name: "Bars", yelpCode: "bars"),
         Category(name: "Coffee & Tea Shops", yelpCode: "coffee"),
         Category(name: "Gyms", yelpCode: "gyms"),
         Category(name: "Landmarks", yelpCode: "landmarks"),
         Category(name: "Music Venues", yelpCode: "musicvenues"),
         Category(name: "Museums", yelpCode: "museums"),
         Category(name: "Restaurants", yelpCode: "restaurants"),
         Category(name: "Shopping", yelpCode: "shoppingcenters") // Restrict to malls for now
    ]

    
    override init() {
        items = categoryArray.map{ CategoryItem(item: $0)}
    }
}

extension ViewCategory: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InterestSelectionCell", for: indexPath) as? InterestSelectionCell {
            cell.item = items[indexPath.row]
            
            // select/deselect the cell
            if items[indexPath.row].isSelected {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: false)
            }
            return cell
        }
        return UITableViewCell()
    }
}
