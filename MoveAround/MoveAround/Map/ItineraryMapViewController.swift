//
//  ItineraryMapViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/22/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import MapKit

class ItineraryMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MapView!
    var places: [Place] = [Place]()
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.places = places
        mapView.parentVC = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onCameraTap(_ sender: UITapGestureRecognizer) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        // Set as mapview's delegate
        mapView.mapView.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera //UIImagePickerControllerSourceType.camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }

    func locationsPickedLocation(controller: LocationsViewController, index: Int) {
        mapView.updateAnnotationImage(position: index, photo: image!)
        controller.navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.image = originalImage
        
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "tagSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tagSegue" {
            let vc = segue.destination as! LocationsViewController
            vc.annotations = mapView.annotations
            vc.delegate = self
        } else if segue.identifier == "fullImageSegue" {
            let fullImageViewController = segue.destination as! FullImageViewController
            let photoView = sender as! PhotoAnnotation
            fullImageViewController.photo = photoView.photo
        }
        
        

    }

}
