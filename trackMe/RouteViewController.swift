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
        
        let location = Location(latitude: "37.8746954926012", longitude: "-82.8481932027648", date: "10/03/2017 04:53:56 PM")
        routeArray.append(location)
        
        let location1 = Location(latitude: "37.8257965157161", longitude: "-82.8230088204917", date: "10/03/2017 04:01:42 PM")
        routeArray.append(location1)

        let location2 = Location(latitude: "37.827207525296", longitude: "-82.8266754840341", date: "10/03/2017 03:58:52 PM")
        routeArray.append(location2)

        let location3 = Location(latitude: "37.8126681922356", longitude: "-82.8118476458665", date: "10/03/2017 03:52:03 PM")
        routeArray.append(location3)

        let location4 = Location(latitude: "37.8061459134076", longitude: "-82.7985372831006", date: "10/03/2017 03:36:09 PM")
        routeArray.append(location4)
 
        let location5 = Location(latitude: "37.8122850086971", longitude: "-82.8028542630684", date: "10/03/2017 03:13:42 PM")
        routeArray.append(location5)

        let location6 = Location(latitude: "37.8060512245053", longitude: "-82.7986935899433", date: "10/03/2017 03:04:51 PM")
        routeArray.append(location6)

        let location7 = Location(latitude: "37.8134944802502", longitude: "-82.8058468737479", date: "10/03/2017 03:00:13 PM")
        routeArray.append(location7)
 
        let location8 = Location(latitude: "37.8155818675066", longitude: "-82.8097044770446", date: "10/03/2017 02:58:52 PM")
        routeArray.append(location8)

        let location9 = Location(latitude: "37.8272470878789", longitude: "-82.8271234967586", date: "10/03/2017 02:55:36 PM")
        routeArray.append(location9)

        let location10 = Location(latitude: "37.8637714404965", longitude: "-82.7898195852365", date: "10/03/2017 02:49:37 PM")
        routeArray.append(location10)

        let location11 = Location(latitude: "37.8569221264104", longitude: "-82.8101244103935", date: "10/03/2017 02:43:05 PM")
        routeArray.append(location11)

        let location12 = Location(latitude: "37.8575462812094", longitude: "-82.8670207786862", date: "10/03/2017 02:32:32 PM")
        routeArray.append(location12)
        
        let location13 = Location(latitude: "37.8536795340944", longitude: "-82.8715181778241", date: "10/03/2017 12:30:57 PM")
        routeArray.append(location13)
        
        let location14 = Location(latitude: "37.8744236240516", longitude: "-82.8476916813132", date: "10/03/2017 12:30:19 PM")
        routeArray.append(location14)

    
        
        
        
        
        for locations in routeArray {
        //set pin
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: Double(locations.latitude)! , longitude: Double(locations.longitude)!)
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
