//
//  Constants.swift
//  Forecast
//
//  Created by Mikko Rouru on 11.6.2017.
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let UNIT_CELSIUS = "&units=metric"
let APP_ID = "&appid="
let API_KEY = "456fa5b69ed6ac0286699089e69e893d"
let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(UNIT_CELSIUS)\(APP_ID)\(API_KEY)"

let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let FORECAST_EXTRA = "&cnt=10&node=json"
let FORECAST_WEATHER_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(UNIT_CELSIUS)\(FORECAST_EXTRA)\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()
