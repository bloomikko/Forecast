//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Mikko Rouru on 12.6.2017.
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {
    }
    
    var latitude: Double!
    var longitude: Double!
}
