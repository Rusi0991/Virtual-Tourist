//
//  ViewController.swift
//  Virtual Tourist
//
//  Created by Ruslan Ismayilov on 11/1/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        dropPin()
    }
    
    func dropPin(){
    
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chosenLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(gestureRecognizer)
       
    }
    @objc func chosenLocation(gestureRecognizer : UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            
        // for converting touched point to coordinates
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            // create a pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            self.mapView.addAnnotation(annotation)
            
        }
    }
//     tells the delegate that user tapped annotation view button
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //To segue to PhotoAlbumView Controller

            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let PhotoAlbumViewController = storyBoard.instantiateViewController(withIdentifier: "PhotoAlbumViewController") as! PhotoAlbumViewController

            let annotation = mapView.selectedAnnotations[0]
            let latitude = annotation.coordinate.latitude
            let longitude = annotation.coordinate.longitude
            let pin = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        PhotoAlbumViewController.latitude = pin.latitude
        PhotoAlbumViewController.longitude = pin.longitude


            self.present(PhotoAlbumViewController, animated: true, completion: nil)
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let annotation = mapView.selectedAnnotations[0]
//        let latitude = annotation.coordinate.latitude
//        let longitude = annotation.coordinate.longitude
//        let pin = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//
//                let PhotoAlbumViewController = storyBoard.instantiateViewController(withIdentifier: "PhotoAlbumViewController") as! PhotoAlbumViewController
//
//        PhotoAlbumViewController.longitude = pin.longitude
//        PhotoAlbumViewController.latitude = pin.latitude
//
//
//                navigationController?.pushViewController(PhotoAlbumViewController, animated: true)
//    }
}

