//
//  InterestSelectionViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/20/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class InterestSelectionViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    let segueToSwipping = "showPlaceSwiping"
    var viewCategory = ViewCategory()
    var itinerary: Itinerary!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = viewCategory
        collectionView.delegate = self
        
        nextButton?.isEnabled = !viewCategory.selectedItems.isEmpty
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewCategory.items[indexPath.item].isSelected = true
        nextButton?.isEnabled = !viewCategory.selectedItems.isEmpty
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewCategory.items[indexPath.item].isSelected = false
        nextButton?.isEnabled = !viewCategory.selectedItems.isEmpty
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToSwipping {
            print(viewCategory.selectedItems.map{$0.name})
            itinerary.interests = viewCategory.selectedItems
            TempCache.sharedInstance.itinerary = itinerary
            
        }
    }

}
