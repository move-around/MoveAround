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
        [Category(name: "Art Galleries", yelpCode: "galleries", imageName: "artgalleries"),
         Category(name: "Bars", yelpCode: "bars", imageName: "bars"),
         Category(name: "Coffee & Tea", yelpCode: "coffee", imageName: "coffeeteashops"),
         Category(name: "Dance Clubs", yelpCode: "danceclubs", imageName: "danceclubs"),
         Category(name: "Desserts", yelpCode: "desserts", imageName: "dessert"),
         Category(name: "Gyms", yelpCode: "gyms", imageName: "gyms"),
         Category(name: "Hikes", yelpCode: "hiking", imageName: "hikes"),
         Category(name: "Landmarks", yelpCode: "landmarks", imageName: "landmarks"),
         Category(name: "Music", yelpCode: "musicvenues", imageName: "musicvenues"),
         Category(name: "Museums", yelpCode: "museums", imageName: "museums"),
         Category(name: "Parks", yelpCode: "parks", imageName: "parks"),
         Category(name: "Restaurants", yelpCode: "restaurants", imageName: "restaurants"),
         Category(name: "Shopping", yelpCode: "shoppingcenters", imageName: "shopping"), // Restrict to malls for now
         Category(name: "Spas", yelpCode: "spas", imageName: "spas"),
         Category(name: "Theaters", yelpCode: "theater", imageName: "theaters")
    ]

    
    override init() {
        items = categoryArray.map{ CategoryItem(item: $0)}
    }
}

extension ViewCategory: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestSelectionCell", for: indexPath) as? InterestSelectionCell {
            cell.item = items[indexPath.row]
            
            // select/deselect the cell
            if items[indexPath.row].isSelected {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            } else {
                collectionView.deselectItem(at: indexPath, animated: true)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
