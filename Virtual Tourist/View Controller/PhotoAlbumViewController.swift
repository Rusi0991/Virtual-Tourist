//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Ruslan Ismayilov on 11/1/21.
//

import UIKit
import MapKit
import CoreData

 
    




class PhotoAlbumViewController: UIViewController,  MKMapViewDelegate, NSFetchedResultsControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var pin : Pin!
    var photo: Photo!
    var dataController : DataController!
    var fetchedResultController : NSFetchedResultsController<Photo>!
    
    
    var fetchedResultsController: NSFetchedResultsController<Photo>!
    
    @IBOutlet weak var mapView2: MKMapView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var collectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       collectionView.delegate = self
       collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        mapView2.delegate = self

        
        let annotation = MKPointAnnotation()
        annotation.coordinate.longitude = pin.longitude
        annotation.coordinate.latitude = pin.latitude
        mapView2.addAnnotation(annotation)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

    func setUpFetchedResultController(){
        let fetchRequest : NSFetchRequest<Photo> = Photo.fetchRequest()
        let predicate = NSPredicate(format : "pin == %@", pin)//fetch to the photos spesific to the clicked pin.
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch  {
            fatalError("The fetch couldn't be performed: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func collectionButtonTapped(_ sender: Any) {
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultController.sections?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
}


