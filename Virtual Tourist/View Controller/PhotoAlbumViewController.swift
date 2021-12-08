//
//  PhotoAlbumViewController.swift
//  Virtual Tourist
//
//  Created by Ruslan Ismayilov on 11/1/21.
//

import UIKit
import MapKit

 
    




class PhotoAlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MKMapViewDelegate {
    
    var pin : Pin!
    var dataController : DataController!
    
    @IBOutlet weak var mapView2: MKMapView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var collectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       collectionView.delegate = self
       collectionView.dataSource = self
        mapView2.delegate = self

        
        let annotation = MKPointAnnotation()
        annotation.coordinate.longitude = pin.longitude
        annotation.coordinate.latitude = pin.latitude
        mapView2.addAnnotation(annotation)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func collectionButtonTapped(_ sender: Any) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        return cell
    }
    
}


