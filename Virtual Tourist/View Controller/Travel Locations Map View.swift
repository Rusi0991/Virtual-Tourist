//
//  ViewController.swift
//  Virtual Tourist
//
//  Created by Ruslan Ismayilov on 11/1/21.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, NSFetchedResultsControllerDelegate  {
    
    
    
    var dataController : DataController!
    var fetchedResultsController : NSFetchedResultsController<Pin>!

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.isUserInteractionEnabled = true
        setUpFetchResultsController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dropPin()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetchedResultsController = nil
    }
    
    
    fileprivate func setUpFetchResultsController() {
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
                fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try? fetchedResultsController.performFetch()
        } catch{
            fatalError("The fetch could not be performed :\(error.localizedDescription)")
        }
    }
    
    
  
    
    func dropPin(){
    
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chosenLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 1.5
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
       
    }
    @objc func chosenLocation(gestureRecognizer : UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .ended {
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            
            
        // for converting touched point to coordinates
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            
            // create a pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            self.mapView.addAnnotation(annotation)
            addPin(lat: touchedCoordinates.latitude, long: touchedCoordinates.longitude)
            print("pin: \(touchedCoordinates.latitude), \(touchedCoordinates.longitude)")
        }
    }
    

    
    func addPin(lat : Double , long : Double){
        let pin = Pin(context: dataController!.viewContext)
        pin.latitude = lat
        pin.longitude = long
        pin.creationDate = Date()
        do {
            try dataController?.viewContext.save()
        } catch {
            
            fatalError("Pin cannot be added :\(error.localizedDescription)")
        }
        
        setUpFetchResultsController() //-> after saving the pin, grab pins from core data again so that it includes the new one.
        
    }
    

    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: false)  // otherwise it always shows same pin. you need to deselect
        
        let latitudeClicked = view.annotation?.coordinate.latitude
        let longitudeClicked = view.annotation?.coordinate.longitude
        
        //Find the clicked pin in Core Data.
        if let pins = fetchedResultsController.fetchedObjects{
            for pin in pins {
                if pin.latitude == latitudeClicked && pin.longitude == longitudeClicked {
                    if let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoAlbumViewController") as? PhotoAlbumViewController {
                        vc.pin = pin
                        vc.dataController = dataController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else {
                        fatalError("error!")
                        
                    }
                }
            }
        }
    }
}


