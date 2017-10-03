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
import MessageUI

class HomeViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var outputDisplay: UITextView!

    
    var locationArray: [Location] = []
    
    var testArray: [String] = []
    
    let keychain = KeychainSwift()
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    let formatter = DateFormatter()
    var saved = ""
    var number = 40000
    var test = 0
    var finalLatitude = "00.000000"
    var finalLongitude = "00.000000"
    var status = ""
    var export = ""
    
    let defaults = UserDefaults.standard
    
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
            finalLatitude = "28.385233"
            finalLongitude = "-81.563874"
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
            
            finalLatitude = String(currentLocation.coordinate.latitude)
            finalLongitude = String(currentLocation.coordinate.longitude)
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
        
        let location = Location(latitude: finalLatitude, longitude: finalLongitude, date: dateString)
        locationArray.append(location)
        
        for locations in locationArray {
            print(locations.date)
        }
        
        // show past pins
        
        for locations in locationArray {
            
            let annotation = MKPointAnnotation()
            //        let centerCoordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
            let centerCoordinate = CLLocationCoordinate2D(latitude: Double(locations.latitude)!, longitude: Double(locations.longitude)!)
            print(locations.date)
            print(locations.latitude)
            print(locations.longitude)
            annotation.coordinate = centerCoordinate
            annotation.title = locations.date
            map.addAnnotation(annotation)
            
        }
        
        export = data
        
        
    }
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["scott_1993@hotmail.com"])
        composeVC.setSubject("Hello!")
        composeVC.setMessageBody(export, isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    
    @IBAction func export(_ sender: Any) {
        sendEmail()
    }
    
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        outputDisplay.text = " "
        getData()
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
