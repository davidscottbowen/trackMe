//
//  HomeViewController.swift
//  trackMe
//
//  Created by David Bowen on 10/1/17.
//  Copyright © 2017 David Bowen. All rights reserved.
//

import UIKit
import MapKit
import MessageUI
import Foundation

class HomeViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var outputDisplay: UITextView!
    
    var gameTimer: Timer!
    
    var pastDataArray: [Location] = []
    
    var locationArray: [Location] = []
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    let formatter = DateFormatter()
    var saved = ""
    var number = 2000000
    var test = 0
    var finalLatitude: Double = 0.0
    var finalLongitude: Double = 0.0
    var status = ""
    var export = ""
    var data = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        gameTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(both), userInfo: nil, repeats: true)
        
        // retrieve saved data
        if let data = UserDefaults.standard.data(forKey: "locationArray"),
            //            let myLocationList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Location] {
            //            myLocationList.forEach({print( $0.date, $0.latitude, $0.longitude)})
            let savedArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Location] {
            //                    savedArray.forEach({print( $0.date, $0.latitude, $0.longitude)})
            locationArray = savedArray
        } else {
            print("Nothing Saved")
        }
        
        
        // retrieve saved data
        if let strings = UserDefaults.standard.data(forKey: "data"),
            //            let myLocationList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Location] {
            //            myLocationList.forEach({print( $0.date, $0.latitude, $0.longitude)})
            let stringer = NSKeyedUnarchiver.unarchiveObject(with: strings) as? String {
            //                    savedArray.forEach({print( $0.date, $0.latitude, $0.longitude)})
            saved = stringer
        } else {
            print("No String Saved")
        }
        
//        both()
        
        phoneData()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        formatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        let dateString = formatter.string(from: Date())
        let latitudeString = "Latitude: " + String(finalLatitude)
        let longitudeString = "Longitude: " + String(finalLongitude)
        let addressString = status
        let currentString = dateString + "\n" + latitudeString + "\n" + longitudeString + "\n" + addressString + "\n" + "\n"
        let data = currentString + saved
        
        saved = data
        
        
        outputDisplay.text = String(describing: data)
        
        export = data
        
        let location = Location(date: dateString, latitude: finalLatitude, longitude: finalLongitude)
        locationArray.append(location)
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: locationArray)
        UserDefaults.standard.set(encodedData, forKey: "locationArray")
        
        let encodedData1 = NSKeyedArchiver.archivedData(withRootObject: data)
        UserDefaults.standard.set(encodedData1, forKey: "data")
        
        for element in locationArray {
            print(element.date, element.latitude, element.longitude)
        }
        
        print("\n")
        
        map.removeAnnotations(map.annotations)
        
        for location in locationArray {
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.coordinate = centerCoordinate
            annotation.title = location.date
            map.addAnnotation(annotation)
        }
        
        
        
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
    
    func both() {
        getLocation()
        getData()
    }
    
    func getLocation() {
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
            //            centerMapOnLocation(location: initialLocation)
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
            //            centerMapOnLocation(location: initialLocation)
            
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
    }
    
    
    func phoneData () {
        
        let location = Location(date: "10/7/17 7:47:17 PM",latitude: 37.8801212227325,longitude: -82.8311794997033)
        let location1 = Location(date: "10/7/17 7:46:58 PM",latitude: 37.8797787476776,longitude: -82.8309750444385)
        let location2 = Location(date: "10/7/17 7:46:57 PM",latitude: 37.879635701422	,longitude: -82.8309059760684)
        let location3 = Location(date: "10/7/17 7:46:24 PM",latitude: 37.8526158159093,longitude: -82.8193915760125)
        let location4 = Location(date: "10/7/17 7:43:23 PM",latitude: 37.839355262483	,longitude: -82.8288390714769)
        let location5 = Location(date: "10/7/17 7:40:23 PM",latitude: 37.8252241305077,longitude: -82.822747209769)
        let location6 = Location(date: "10/7/17 7:39:23 PM",latitude: 37.8222516831363,longitude: -82.8179818578836)
        let location7 = Location(date: "10/7/17 7:34:51 PM",latitude: 37.8220687864357,longitude: -82.817499864631)
        let location8 = Location(date: "10/7/17 7:32:51 PM",latitude: 37.8222953109423,longitude: -82.8180286289033)
        let location9 = Location(date: "10/7/17 7:31:51 PM",latitude: 37.8243867236626,longitude: -82.8187528938687)
        let location10 = Location(date: "10/7/17 7:30:51 PM",latitude: 37.8250742870302,longitude: -82.8209850397437)
        let location11 = Location(date: "10/7/17 7:29:59 PM",latitude: 37.8254007231305,longitude: -82.8221336470971)
        let location12 = Location(date: "10/7/17 7:29:51 PM",latitude: 37.8254459449652,longitude: -82.8225624813059)
        let location13 = Location(date: "10/7/17 7:29:41 PM",latitude: 37.8254779845304,longitude: -82.8226510303971)
        let location14 = Location(date: "10/7/17 7:29:21 PM",latitude: 37.8253235700183,longitude: -82.8231088247365)
        let location15 = Location(date: "10/7/17 7:01:45 PM",latitude: 37.8234137233949,longitude: -82.8247572435039)
        let location16 = Location(date: "10/7/17 7:01:34 PM",latitude: 37.8235313621465,longitude: -82.8249596449181)
        let location17 = Location(date: "10/7/17 7:00:18 PM",latitude: 37.8233017746241,longitude: -82.8244852603514)
        let location18 = Location(date: "10/7/17 6:56:18 PM",latitude: 37.8246606470944,longitude: -82.8194949357678)
        let location19 = Location(date: "10/7/17 6:52:52 PM",latitude: 37.8250219648206,longitude: -82.8211825914817)
        let location20 = Location(date: "10/7/17 6:50:57 PM",latitude: 37.832718354834	,longitude: -82.8279786504845)
        let location21 = Location(date: "10/7/17 6:48:52 PM",latitude: 37.856213487712	,longitude: -82.8323133521379)
        let location22 = Location(date: "10/7/17 6:47:52 PM",latitude: 37.8894624086851,longitude: -82.8316840715282)
        let location23 = Location(date: "10/7/17 6:45:52 PM",latitude: 37.8856059001947,longitude: -82.8323438626057)
        let location24 = Location(date: "10/7/17 6:44:52 PM",latitude: 37.8812245226097,longitude: -82.8385507053019)
        let location25 = Location(date: "10/7/17 6:43:52 PM",latitude: 37.8811901209923,longitude: -82.845235011419)
        let location26 = Location(date: "10/7/17 6:42:52 PM",latitude: 37.8757442013689,longitude: -82.849266085615)
        let location27 = Location(date: "10/7/17 6:41:52 PM",latitude: 37.8744589436955,longitude: -82.8480249516337)
        
        
        pastDataArray.append(location)
        pastDataArray.append(location1)
        pastDataArray.append(location2)
        pastDataArray.append(location3)
        pastDataArray.append(location4)
        pastDataArray.append(location5)
        pastDataArray.append(location6)
        pastDataArray.append(location7)
        pastDataArray.append(location8)
        pastDataArray.append(location9)
        pastDataArray.append(location10)
        pastDataArray.append(location11)
        pastDataArray.append(location12)
        pastDataArray.append(location13)
        pastDataArray.append(location14)
        pastDataArray.append(location15)
        pastDataArray.append(location16)
        pastDataArray.append(location17)
        pastDataArray.append(location18)
        pastDataArray.append(location19)
        pastDataArray.append(location20)
        pastDataArray.append(location21)
        pastDataArray.append(location22)
        pastDataArray.append(location23)
        pastDataArray.append(location24)
        pastDataArray.append(location25)
        pastDataArray.append(location26)
        pastDataArray.append(location27)
        
        
        
        for location in pastDataArray {
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.coordinate = centerCoordinate
            annotation.title = location.date
            map.addAnnotation(annotation)
        }
    }
    
    
    @IBAction func export(_ sender: Any) {
        sendEmail()
    }
    
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        outputDisplay.text = " "
        getLocation()
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
