//
//  PlaceDetailViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/13/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.

import UIKit
import MapKit


let UBER_CLIENT_ID = "ELWHEjVhHS85M0PHckqt8KVCtzMwSoJz"
class PlaceDetailViewController: UIViewController  {

    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var uberButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var place: Place!
    var wasShook: Bool = false // Whether coming from a shake
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = place.imageURL {
            placeImageView.setImageWith(url)
        }
        nameLabel.text = place.name
        if let ratingImageString = place.ratingImage {
            ratingImageView.image = UIImage(named: ratingImageString)
        }
        
        addressLabel.text = place.address
        categoriesLabel.text = place.categories
        let reviewCount = String(describing: place.reviewCount!)
        reviewsCountLabel.text = "\(reviewCount) ratings"
        
        if (place.phoneNumber ?? "").isEmpty {
            callButton.isHidden = true
        }

        mapView.places = [place]
        
        uberButton.layer.cornerRadius = 22
        callButton.layer.cornerRadius = 22

//        shakeButton.isHidden = wasShook ? false : true
    }
    
    @IBAction func onUberTap(_ sender: UIButton) {
        let destinationLatitude = String(describing: place.latitude!)
        let destinationLongitude = String(describing: place.longitude!)
        let address = place.address!
        let name = place.name!
        
        let uberUrl = "uber://?client_id=\(UBER_CLIENT_ID)&action=setPickup&pickup=my_location&dropoff[latitude]=\(destinationLatitude)&dropoff[longitude]=\(destinationLongitude)&dropoff[nickname]=\(name)&dropoff[formatted_address]=\(address)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        if let url = URL(string: uberUrl!) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("Uber url : \(success)")
                })
            }
        }
    }

    @IBAction func onReviewsTap(_ sender: UIButton) {
        if let url = URL(string: place.url!) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("Yelp open url : \(success)")
                })
            }
        }
    }
    
    @IBAction func onCallTap(_ sender: UIButton) {
        // Have to run on a device to test
        if let number = place.phoneNumber {
            let url: NSURL = URL(string: "TEL://\(number)")! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func onDirectionsTap(_ sender: UIButton) {
        let coordinate = CLLocationCoordinate2DMake(place.latitude!, place.longitude!)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = place.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }

    @IBAction func onBackTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    static func storyboardInstance() -> PlaceDetailViewController? {
        let storyboard = UIStoryboard(name: String(describing: type(of: self)), bundle: nil)
        return storyboard.instantiateInitialViewController() as? PlaceDetailViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
