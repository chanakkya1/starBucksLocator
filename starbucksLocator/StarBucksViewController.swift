//
//  ViewController.swift
//  starbucksLocator
//
//  Created by chanakkya mati on 4/22/17.
//  Copyright © 2017 chanakkya mati. All rights reserved.
//

import UIKit
import CoreLocation

class StarBucksSearchViewController: UIViewController,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var findStarbucksButton: UIButton!
    var dataSource:[CLLocationCoordinate2D]! = []
    var dataManager = DataManager()
    var currentLocation = Location(latitude: "",longitude: ""){
        didSet{
            self.dataManager.location = currentLocation
            self.findStarbucksButton.isEnabled = true
            self.findStarbucksButton.alpha = 1.0
        }
    }
    var locationManager : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.findStarbucksButton.isEnabled = false
        self.locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70;
        self.findStarbucksButton.alpha = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        let location = locations.last! as CLLocation
        self.currentLocation = Location(latitude: String(location.coordinate.latitude),longitude: String(location.coordinate.longitude))
    }
    
    @IBAction func findStarbucksButtonTapped(_ sender: Any) {
        locationManager.startUpdatingLocation()
        let loadingView = UIView(frame: self.view.bounds)
        loadingView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let activityView = UIActivityIndicatorView(activityIndicatorStyle:.whiteLarge)
        activityView.center = loadingView.center
        loadingView.addSubview(activityView)
        self.view.addSubview(loadingView)
        activityView.startAnimating()
        dataManager.fetchStarbucks {[weak self] (responseStatus, locations) in
            if case  Status.success = responseStatus{
                self?.dataSource = locations
                self?.tableView.reloadData()
                activityView.stopAnimating()
                loadingView.removeFromSuperview()
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                 sender: Any?){
     let cell = sender as! UITableViewCell
     let vc = segue.destination as! ViewController
     vc.location = self.dataSource[self.tableView.indexPath(for: cell)!.row]
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell",
                                                 for: indexPath) as! LocationCell
        let location = self.dataSource[indexPath.row]
        cell.latitudeLabel.text = String(location.latitude)
        cell.longitudeLabel.text = String(location.longitude)
        return cell
    }
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       let location = self.dataSource[indexPath.row]
//       
//    }
    
    
    
}

