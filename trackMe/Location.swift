//
//  Location.swift
//  trackMe
//
//  Created by David Bowen on 10/3/17.
//  Copyright © 2017 David Bowen. All rights reserved.
//

import UIKit

class Location: NSObject, NSCoding {
    let date: String
    let latitude: Double
    let longitude: Double
    
    init(date: String, latitude: Double, longitude: Double) {
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
    }
    required init(coder decoder: NSCoder) {
        self.date = decoder.decodeObject(forKey: "date") as? String ?? ""
        self.latitude = decoder.decodeDouble(forKey: "latitude")
        self.longitude = decoder.decodeDouble(forKey: "longitude")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(date, forKey: "date")
        coder.encode(latitude, forKey: "latitude")
        coder.encode(longitude, forKey: "longitude")
        
    }
}

