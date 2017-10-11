//
//  DrawRouteViewController.swift
//  trackMe
//
//  Created by David Bowen on 10/3/17.
//  Copyright © 2017 David Bowen. All rights reserved.
//

import UIKit
import MapKit

class DrawRouteViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    var myRoute : MKRoute!

    override func viewDidLoad() {
        super.viewDidLoad()

        let point1 = MKPointAnnotation()
        let point2 = MKPointAnnotation()
        
        point1.coordinate = CLLocationCoordinate2DMake(37.8257965157161, -82.8230088204917)
        point1.title = "Taipei"
        point1.subtitle = "Taiwan"
        myMap.addAnnotation(point1)
        
        point2.coordinate = CLLocationCoordinate2DMake(37.8061459134076, -82.7985372831006)
        point2.title = "Chungli"
        point2.subtitle = "Taiwan"
        myMap.addAnnotation(point2)
        myMap.centerCoordinate = point2.coordinate
        myMap.delegate = self
        
        //Span of the map
        
        myMap.setRegion(MKCoordinateRegionMake(point2.coordinate, MKCoordinateSpanMake(0.7,0.7)), animated: true)
        
        let directionsRequest = MKDirectionsRequest()
        
        let markTaipei = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point1.coordinate.latitude, point1.coordinate.longitude), addressDictionary: nil)
        
        let markChungli = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
        
        directionsRequest.source = MKMapItem(placemark: markChungli)
        directionsRequest.destination = MKMapItem(placemark: markTaipei)
        
        directionsRequest.transportType = MKDirectionsTransportType.automobile
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate(completionHandler: {
            
            response, error in
            
            if error == nil {
                
                self.myRoute = response!.routes[0] as MKRoute
                
                self.myMap.add(self.myRoute.polyline)
                
            }
        })
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->MKOverlayRenderer {
        
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        
        myLineRenderer.strokeColor = UIColor.blue
        
        myLineRenderer.lineWidth = 3
        
        return myLineRenderer
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
