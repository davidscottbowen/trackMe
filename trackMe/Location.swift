//
//  Location.swift
//  trackMe
//
//  Created by David Bowen on 10/3/17.
//  Copyright © 2017 David Bowen. All rights reserved.
//

import UIKit

class Location {
    var latitude: String!
    var longitude: String!
    var date: String!
    
    init(latitude: String, longitude: String, date: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
    }
}

