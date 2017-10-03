//
//  HomeViewController.swift
//  trackMe
//
//  Created by David Bowen on 10/1/17.
//  Copyright © 2017 David Bowen. All rights reserved.
//

import UIKit
import MapKit
import KeychainSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var outputDisplay: UITextView!
    
    @IBOutlet weak var slider: UISlider!
    
    let keychain = KeychainSwift()
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    let formatter = DateFormatter()
    var saved = ""
    var number = 40000
    var test = 0
    var finalLatitude = 00.000000
    var finalLongitude = 00.000000
    var status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentLocation = locManager.location
        
        if currentLocation == nil {
            // set initial location
            let initialLocation = CLLocation(latitude: 28.385233, longitude: -81.563874)
            let regionRadius: CLLocationDistance = CLLocationDistance(number)
            func centerMapOnLocation(location: CLLocation) {
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                          regionRadius, regionRadius)
                map.setRegion(coordinateRegion, animated: true)
            }
            centerMapOnLocation(location: initialLocation)
            finalLatitude = 28.385233
            finalLongitude = -81.563874
            status = "Location wasn't available"
            
        } else {
        
        
        // set initial location
        let initialLocation = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let regionRadius: CLLocationDistance = CLLocationDistance(number)
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius, regionRadius)
            map.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
            
            finalLatitude = currentLocation.coordinate.latitude
            finalLongitude = currentLocation.coordinate.longitude
            status = "Real Location"
        
        }
        
        // show location pin on map - user location
        
        if currentLocation == nil {
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: 28.385233, longitude: -81.563874)
        //        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.815446, longitude: -82.809549)
        annotation.coordinate = centerCoordinate
        annotation.title = "Title"
        map.addAnnotation(annotation)
            
        } else {
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
            //        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.815446, longitude: -82.809549)
            annotation.coordinate = centerCoordinate
            annotation.title = "Title"
            map.addAnnotation(annotation)
            
            
        }
        
        outputDisplay.text = " "
        
        getData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        let checkForSave = keychain.get("my key")
        
        if checkForSave == nil {
            saved = ""
        } else {
            saved = checkForSave!
        }
        formatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        let dateString = formatter.string(from: Date())
        let latitudeString = "Latitude: " + String(finalLatitude)
        let longitudeString = "Longitude: " + String(finalLongitude)
        let addressString = status
        let currentString = dateString + "\n" + latitudeString + "\n" + longitudeString + "\n" + addressString + "\n" + "\n"
        let data = currentString + saved
        
        outputDisplay.text = String(describing: data)
        
        keychain.set(data, forKey: "my key")
        
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        print(String(Int(sender.value)))
        let initialLocation = CLLocation(latitude: 37.815446, longitude: -82.809549)
        let regionRadius: CLLocationDistance = CLLocationDistance(Int(sender.value))
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius, regionRadius)
            map.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
        number = Int(sender.value)
    }
    
    
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        outputDisplay.text = " "
        getData()
    }
    
    
    @IBAction func zoomInButtonTapped(_ sender: Any) {
        // set initial location to Paintsville KY
        if number > 5000 {
            number = number - 5000
        } else if number > 0 {
            number = number - 1000
        } else {
            number = 0
        }
        print(number)
        let initialLocation = CLLocation(latitude: 37.815446, longitude: -82.809549)
        let regionRadius: CLLocationDistance = CLLocationDistance(number)
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius, regionRadius)
            map.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
        
    }
    
    
    @IBAction func zoomOutButtonTapped(_ sender: Any) {
        // set initial location to Paintsville KY
        number = number + 40000
        print(number)
        let initialLocation = CLLocation(latitude: 37.815446, longitude: -82.809549)
        let regionRadius: CLLocationDistance = CLLocationDistance(number)
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius, regionRadius)
            map.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
