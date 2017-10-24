//
//  PlacesListViewController.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/14/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

class PlacesListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listOfPlaces: [Place]?
    var searchBar:UISearchBar!
    let NUM_PLACES_PER_ROW = 2
    let NUM_SEARCH_RESULTS_TO_LOAD: Int = 20
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    var isShowingSelectedPlaces: Bool = false
    var cellRowForItineraryView: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate for collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if !isShowingSelectedPlaces {
            // Initialize the UISearchBar
            searchBar = UISearchBar()
            searchBar.delegate = self
            
            // Add SearchBar to the NavigationBar
            searchBar.sizeToFit()
            navigationItem.titleView = searchBar
            searchBar.tintColor = UIColor.white
            searchBar.placeholder = "Landmarks"
            
            
            // Add Scroll Loading view for infinite scrolling
            let frame = CGRect(x: 0, y: collectionView.contentSize.height, width: collectionView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
            loadingMoreView = InfiniteScrollActivityView(frame: frame)
            loadingMoreView!.isHidden = true
            collectionView.addSubview(loadingMoreView!)
            
            var insets = collectionView.contentInset
            insets.bottom += InfiniteScrollActivityView.defaultHeight
            collectionView.contentInset = insets
            
            // Perform the first search when the view controller first loads
            doSearch(searchString: "Landmarks", useOffset: false)
            
            // Set Tab bar item title
            self.navigationController?.tabBarItem.title = "Explore"

        }
        else {
            listOfPlaces = Itinerary.currentItinerary.placesOfInterest
            collectionView.reloadData()
        }
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapEdit(recognizer:)))
        collectionView.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        
    }
    
    func doSearch(searchString: String, useOffset: Bool) {
        var searchTerm = searchString
        if (searchString.isEmpty) {
            searchTerm = searchBar.placeholder ?? ""
        }
        var offset:Int = 0
        if useOffset {
            offset = listOfPlaces?.count ?? 0
        }
        YelpPlace.searchWithTerm(term: searchTerm, offset: offset) { (places: [Place]?, error: Error?) in
            if (places != nil) {
                if useOffset {
                    self.listOfPlaces?.append(contentsOf: places!)
                } else {
                    self.listOfPlaces = places!
                }
            }
            self.collectionView.reloadData()
            self.isMoreDataLoading = false
            self.loadingMoreView!.stopAnimating()
            // Move scroll view to top
            // TODO (Mohit) Fix this
            if !useOffset {
                //self.collectionView.setContentOffset(CGPoint.zero, animated: true)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Collection View functions
    func totalNumberOfPlaces() -> Int {
        return (listOfPlaces?.count) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (totalNumberOfPlaces() + 1)/NUM_PLACES_PER_ROW
    }
    
    // Number of movies to be shown in each row
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        var numberOfItems: Int
        if (section + 1) == numberOfSections(in: collectionView) {
            numberOfItems = totalNumberOfPlaces() - section*NUM_PLACES_PER_ROW
        }
        else {
            numberOfItems = NUM_PLACES_PER_ROW
        }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacesCollectionViewCell", for: indexPath) as! PlacesCollectionViewCell
        
        let placeIndex = indexPath.section*NUM_PLACES_PER_ROW + indexPath.row;
        cell.place = listOfPlaces![placeIndex]
        cell.isPreSelected = isShowingSelectedPlaces
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Compute the dimension of a cell for an NxN layout with space S between
        // cells.  Take the collection view's width, subtract (N-1)*S points for
        // the spaces between the cells, and then divide by N to find the final
        // dimension for the cell's width and height.
        
        let width: CGFloat = collectionView.bounds.width/2 - 20
        return CGSize(width: width, height: 250)
    }
    
    
    // MARK:- Search view functions
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        doSearch(searchString: searchBar.text!, useOffset: false)
        searchBar.resignFirstResponder()
    }
    
    // MARK:- Scroll view functions
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = collectionView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - 2*collectionView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold &&
                collectionView.isDragging &&
                (listOfPlaces?.count)! >= NUM_SEARCH_RESULTS_TO_LOAD) {
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: collectionView.contentSize.height, width: collectionView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                isMoreDataLoading = true
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        doSearch(searchString: searchBar.text!, useOffset: true)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            let vc = segue.destination as! PlaceDetailViewController
            vc.place = sender as! Place
        }
    }
    
    // MARK: - TapGestureRecognizer
    @objc func tapEdit(recognizer: UITapGestureRecognizer)  {
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self.collectionView)
            if let tapIndexPath = self.collectionView.indexPathForItem(at: tapLocation) {
                if !isShowingSelectedPlaces {
                    // This view was shown from TabBar
                    performSegue(withIdentifier: "showDetail", sender: listOfPlaces?[tapIndexPath.section*NUM_PLACES_PER_ROW + tapIndexPath.row])
                }
                else {
                    // This view was shown through itinerary view
                    let i = navigationController?.viewControllers.index(of: self)
                    let previousViewController = navigationController?.viewControllers[i!-1] as! ItineraryViewController
                    let cell = previousViewController.tableView.cellForRow(at: IndexPath(row: cellRowForItineraryView!, section: 0)) as! ItineraryTableViewCell
                    let newPlaceForCell = listOfPlaces?[tapIndexPath.section*NUM_PLACES_PER_ROW + tapIndexPath.row]
                    // Remove the place from placesOfInterest and add it to plannedPlaces list for itinerary
                    if let oldPlaceForCell = cell.place {
                        if let index = Itinerary.currentItinerary.plannedPlaces.index(of: oldPlaceForCell) {
                            Itinerary.currentItinerary.plannedPlaces.remove(at: index)
                        }
                        Itinerary.currentItinerary.placesOfInterest.append(oldPlaceForCell)
                    }
                    Itinerary.currentItinerary.plannedPlaces.append(newPlaceForCell!)
                    if let index = Itinerary.currentItinerary.placesOfInterest.index(of: newPlaceForCell!) {
                        Itinerary.currentItinerary.placesOfInterest.remove(at: index)
                    }
                    cell.setSelectedPlace(selectedPlace: newPlaceForCell!)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
}

