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
    
    
    let keychain = KeychainSwift()
    let formatter = DateFormatter()
    var saved = ""

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show location pin on map
        let annotation = MKPointAnnotation()
//      let centerCoordinate = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.815446, longitude: -82.809549)
                annotation.coordinate = centerCoordinate
                annotation.title = "Title"
                map.addAnnotation(annotation)
        
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
        let latitudeString = "Latitude: 37.815446"
        let longitudeString = "Longitude: -82.809549"
        let addressString = "Address: 513 3rd St, Paintsville, KY 41240"
        let currentString = dateString + "\n" + latitudeString + "\n" + longitudeString + "\n" + addressString + "\n" + "\n"
        let data = currentString + saved
        
        outputDisplay.text = String(describing: data)
        
        keychain.set(data, forKey: "my key")
        
    }
    
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        outputDisplay.text = " "
        getData()
    }
    
    
    @IBAction func zoomInButtonTapped(_ sender: Any) {
        map.isZoomEnabled = true
        
    }
    
    
    @IBAction func zoomOutButtonTapped(_ sender: Any) {
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
