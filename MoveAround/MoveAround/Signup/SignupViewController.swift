//
//  SignupViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/15/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import GooglePlaces

class SignupViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var cities = [City]()
    
    var defaultCities=[
        City(name: "San Francisco, CA, United States", imageName: "sanfrancisco", imageUrl: nil),
        City(name: "London, United Kingdom", imageName: "london", imageUrl: nil),
        City(name: "Toronto, ON, Canada", imageName: "toronto", imageUrl: nil),
        City(name: "New York, NY, United States", imageName: "newyork", imageUrl: nil),
        City(name: "Moscow, Russia", imageName: "moscow", imageUrl: nil),
        City(name: "Manhattan Beach, CA, United States", imageName: "manhattanbeach", imageUrl: nil),
        City(name: "Shanghai, China", imageName: "shanghai", imageUrl: nil),
        City(name: "Berlin, Germany", imageName: "berlin", imageUrl: nil),
        City(name: "Paris, France", imageName: "paris", imageUrl: nil)
    ]

    
    
    var fetcher: GMSAutocompleteFetcher?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentUser = User.currentUser {
            greeting.text = "Welcome \(currentUser.firstName!)."
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
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // Remove search bar border
        searchBar.backgroundImage = UIImage()
        tableView.tableFooterView = UIView()
        
        cities = defaultCities
        
        let orangeColor = UIColor(hex: "FF7112")
        searchBar.searchBarStyle = .minimal
        searchBar.setTextColor(color: orangeColor)
        searchBar.setPlaceholderTextColor(color: orangeColor)
        searchBar.setSearchImageColor(color: orangeColor)
        searchBar.setTextFieldClearButtonColor(color: orangeColor)
    
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        fetcher?.sourceTextHasChanged(searchBar.text!)
        
  
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        let city = cities[indexPath.row]
        cell.nameLabel.text = city.name
        
        if let posterName = city.imageName {
            cell.posterView.image = UIImage(named: posterName)
        } else if let posterUrl = city.imageUrl {
            let imageRequest = URLRequest(url: URL(string: posterUrl)!)
            cell.posterView.setImageWith(imageRequest, placeholderImage: nil, success: { (imageRequest, imageResponse, image) -> Void in
                // imageResponse will be nil if the image is cached
                if imageResponse != nil {
                    //print("Image was NOT cached, fade in image")
                    cell.posterView.alpha = 0.0
                    cell.posterView.image = image
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        cell.posterView.alpha = 1.0
                    })
                } else {
                    //print("Image was cached so just update the image")
                    cell.posterView.image = image
                }
            }
            )
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetcher?.sourceTextHasChanged(searchText)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showRoutes", sender: cities[indexPath.row])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itinerary = Itinerary.currentItinerary
        let city = sender as! City
        itinerary.destination = city.name
        Itinerary.currentItinerary = itinerary
    }

}


extension SignupViewController: GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        cities.removeAll()
        
        for prediction in predictions {

            let placeId = prediction.placeID
            GooglePlacesClient.getPhotoUrl(placeId, completion: { (photoUrl) in
                let city = City(name: prediction.attributedFullText.string, imageName: nil, imageUrl: photoUrl)
                self.cities.append(city)
                
                // This isn't optimal here but leaving it. Let's re-visit this when we have more time.
                self.tableView.reloadData()
            })

//            print("\n",prediction.attributedFullText.string)
//            print("\n",prediction.attributedPrimaryText.string)
//            print("\n********")
        }
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        //resultText?.text = error.localizedDescription
        print(error.localizedDescription)
    }
}
