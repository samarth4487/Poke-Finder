//
//  ViewController.swift
//  Poke Finder
//
//  Created by Samarth Paboowal on 25/08/16.
//  Copyright © 2016 Junkie Labs. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var mapHasCentredOnce = false
    
    var geoFire: GeoFire!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.Follow
    }
    
    override func viewDidAppear(animated: Bool) {
        
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
            mapView.showsUserLocation = true
        } else {
            
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            
            mapView.showsUserLocation = true
        }
    }
    
    func centreMapLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        if let location = userLocation.location {
            
            if !mapHasCentredOnce {
                centreMapLocation(location)
                mapHasCentredOnce = true
            }
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView: MKAnnotationView?
        
        if annotation.isKindOfClass(MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named: "ash")
        }
        
        return annotationView
    }

    @IBAction func generateRandomPokemon(sender: UIButton) {
        
    }
}

