//
//  MapView.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/22/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView, MKMapViewDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var places: [Place] = [Place]() {
        didSet {
            // Default to SF for now
            var centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
            if places.count > 0 {
                let place = places[0] // Grab the first item for a center location
                if let latitude = place.latitude, let longitude = place.longitude {
                    centerLocation = CLLocation(latitude: latitude, longitude: longitude)
                }
            }
            goToLocation(location: centerLocation)
            
            for (index, place) in places.enumerated() {
                if let latitude = place.latitude, let longitude = place.longitude {
                    addAnnotationAtCoordinate(position: index, name: place.name!, coordinate: CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude))
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "MapView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    func addAnnotationAtCoordinate(position: Int, name: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        if places.count > 1 {
            annotation.title = "\(position + 1) - \(name)" // Temporary for now until we figure out the design
        }
        mapView.addAnnotation(annotation)
    }
}
