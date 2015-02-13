//
//  ViewController.swift
//  CoreLocation
//
//  Created by Shrikar Archak on 12/27/14.
//  Copyright (c) 2014 Shrikar Archak. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    var manager: CLLocationManager?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var address: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager?.delegate = self;
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func getLocation(sender: AnyObject) {
//        let available = CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion)
        manager?.requestWhenInUseAuthorization()
        manager?.startUpdatingLocation()
        

    }
    
    
    @IBAction func regionMonitoring(sender: AnyObject) {
        manager?.requestAlwaysAuthorization()
        
        let currRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.411822, longitude: -121.941125), radius: 200, identifier: "Home")
        manager?.startMonitoringForRegion(currRegion)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        manager.stopUpdatingLocation()
        let location = locations[0] as CLLocation
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (data, error) -> Void in
            let placeMarks = data as [CLPlacemark]
            let loc: CLPlacemark = placeMarks[0]

            self.mapView.centerCoordinate = location.coordinate
            let addr = loc.locality
            self.address.text = addr
            let reg = MKCoordinateRegionMakeWithDistance(location.coordinate, 1500, 1500)
            self.mapView.setRegion(reg, animated: true)
            self.mapView.showsUserLocation = true
     
        })
    }

    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        NSLog("Entering region")
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        NSLog("Exit region")
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("\(error)")
    }
    
}

