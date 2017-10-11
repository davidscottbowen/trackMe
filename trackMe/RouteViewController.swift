//
//  RouteViewController.swift
//  trackMe
//
//  Created by David Bowen on 10/3/17.
//  Copyright © 2017 David Bowen. All rights reserved.
//

import UIKit
import MapKit

class RouteViewController: UIViewController {
    
    @IBOutlet weak var routeMap: MKMapView!
    
    var routeArray: [Location] = []
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = Location(date: "10/03/2017 04:53:56 PM", latitude: 37.8746954926012, longitude: -82.8481932027648)
        routeArray.append(location)
        
        let location1 = Location(date: "10/03/2017 04:01:42 PM", latitude: 37.8257965157161, longitude: -82.8230088204917)
        routeArray.append(location1)


    
//        let sourceLocation = CLLocationCoordinate2D(latitude: 37.8257965157161, longitude: -82.8230088204917)
//        let destinationLocation = CLLocationCoordinate2D(latitude: 37.8061459134076, longitude: -82.7985372831006)
        
        
        
        for locations in routeArray {
        //set pin
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: locations.latitude , longitude: locations.longitude)
        annotation.coordinate = centerCoordinate
        annotation.title = locations.date
        routeMap.addAnnotation(annotation)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
