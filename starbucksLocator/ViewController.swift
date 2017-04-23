//
//  ViewController.swift
//  Map
//
//  Created by Ashwin Tallapaka on 4/22/17.
//  Copyright © 2017 Ashwin Tallapaka. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var location:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let location = CLLocationCoordinate2DMake(48.83664488641497, 2.320432662963867)
// mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 2000, 2000), animated: true)
//        
//        let pin = PinAnnotation(title: "Eiffel Tower", subtitle: "One of the Seventh wonder!!", coordinate: location)
//        mapView.addAnnotation(pin)
 
        
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Starbucks"
        annotation.subtitle = "Cafe"
        mapView.addAnnotation(annotation)
        
    }

   }

