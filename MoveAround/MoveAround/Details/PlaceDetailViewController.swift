//
//  PlaceDetailViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/13/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.

import UIKit
import MapKit

class PlaceDetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var itineraryTime: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!

    var place: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = place.imageURL {
            placeImageView.setImageWith(url)
        }
        nameLabel.text = place.name
        if let url = place.ratingImageURL {
            ratingImageView.setImageWith(url)
        }
        addressLabel.text = place.address
        hoursLabel.text = place.hours
        categoriesLabel.text = place.categories
        itineraryTime.text = place.itineraryTime
        
        let centerLocation = CLLocation(latitude: place.latitude!, longitude: place.longitude!)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(centerLocation.coordinate, span)
        mapView.setRegion(region, animated: false)

        addAnnotationAtCoordinate(title: place.name!, coordinate: CLLocationCoordinate2D.init(latitude: place.latitude!, longitude: place.longitude!))

    }
    
    func addAnnotationAtCoordinate(title: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
    
    static func storyboardInstance() -> PlaceDetailViewController? {
        let storyboard = UIStoryboard(name: String(describing: type(of: self)), bundle: nil)
        return storyboard.instantiateInitialViewController() as? PlaceDetailViewController
    }

    @IBAction func onDirectionsTapped(_ sender: UIButton) {
    }    
    
    @IBAction func onReserveTapped(_ sender: UIButton) {
    }
    
    @IBAction func onImageTap(_ sender: UITapGestureRecognizer) {
        // Temporary for now until we hook up the flows properly
        dismiss(animated: true, completion: nil)

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
