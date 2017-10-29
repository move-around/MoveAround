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
    var annotations: [PhotoAnnotation] = [PhotoAnnotation]()
    var image:UIImage?
    var parentVC: UIViewController = UIViewController()
    
    var places: [Place] = [Place]() {
        didSet {
            for (index, place) in places.enumerated() {
                if let latitude = place.latitude, let longitude = place.longitude {
                    addAnnotationAtCoordinate(position: index, name: place.name!, coordinate: CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude))
                }
            }
            mapView.showAnnotations(annotations, animated: true)

            // Default to SF for now
            var centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
            if places.count > 0 {
                let place = places[0] // Grab the first item for a center location
                if let latitude = place.latitude, let longitude = place.longitude {
                    centerLocation = CLLocation(latitude: latitude, longitude: longitude)
                }
            }
            goToLocation(location: centerLocation)
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
        mapView.delegate = self
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.01, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotationView"
        
        let myAnnotation = annotation as! PhotoAnnotation

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
//            annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
            annotationView!.canShowCallout = true
        }
        
        let resizeRenderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        resizeRenderImageView.layer.borderColor = UIColor.white.cgColor
        resizeRenderImageView.layer.borderWidth = 0.0
        resizeRenderImageView.contentMode = .scaleAspectFit
        
        let pinPhoto: UIImage!
        if places.count == 1 {
            pinPhoto = UIImage(named: "number_0")
        } else {
            let number = myAnnotation.index!
            pinPhoto = UIImage(named: "number_\(number)")
        }
        
        resizeRenderImageView.image = pinPhoto
        
        UIGraphicsBeginImageContext(resizeRenderImageView.frame.size)
        resizeRenderImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
//        let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
//        imageView.image = thumbnail
        
        
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        annotationView!.image = thumbnail
        
        return annotationView
    }
    
    
    func calculateDirections(startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D) {
        let startPlacemark = MKPlacemark(coordinate: startCoordinate)
        let endPlacemark = MKPlacemark(coordinate: endCoordinate)
        let startMapItem = MKMapItem(placemark: startPlacemark)
        let endMapItem = MKMapItem(placemark: endPlacemark)

        let directionRequest = MKDirectionsRequest()
        directionRequest.source = startMapItem
        directionRequest.destination = endMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
//            let rect = route.polyline.boundingMapRect
//            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        parentVC.performSegue(withIdentifier: "fullImageSegue", sender: view.annotation)
        
    }
    
    func updateAnnotationImage(position: Int, photo: UIImage) {

        let resizeRenderImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        resizeRenderImageView.layer.borderColor = UIColor.white.cgColor
        resizeRenderImageView.layer.borderWidth = 0.0
        resizeRenderImageView.contentMode = .scaleAspectFit
        resizeRenderImageView.image = photo
        
        UIGraphicsBeginImageContext(resizeRenderImageView.frame.size)
        resizeRenderImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let annotation = annotations[position]
        let anView = mapView.view(for: annotation)
        anView?.image = thumbnail
        
        //annotationView!.image = thumbnail
        
//        mapView.removeAnnotation(annotation)
//        DispatchQueue.main.async {
//            self.mapView.addAnnotation(annotation)
//            self.mapView.showAnnotations(self.annotations, animated: false)
//        }
//
        annotations[position] = annotation
    }
    
    func addAnnotationAtCoordinate(position: Int, name: String, coordinate: CLLocationCoordinate2D) {
        let annotation = PhotoAnnotation()
    
        annotation.coordinate = coordinate
        if places.count > 1 {
            annotation.pinTitle = "#\(position + 1) - \(name)"
        }
        annotation.index = position+1

        // Add a route
        if position > 0 {
            let startCoordinate = annotations[position - 1].coordinate
            let endCoordinate = coordinate // current
            calculateDirections(startCoordinate: startCoordinate, endCoordinate: endCoordinate)
        }
        annotations.append(annotation)
    }
}
