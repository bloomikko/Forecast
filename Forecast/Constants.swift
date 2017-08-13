//
//  Constants.swift
//  Forecast
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import Foundation

let LATITUDE = "lat="
let LONGITUDE = "&lon="
let UNIT_CELSIUS = "&units=metric"
let UNIT_FAHRENHEIT = "&units=imperial"
let APP_ID = "&appid="
let API_KEY = "456fa5b69ed6ac0286699089e69e893d"

let CURRENT_BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let CURRENT_CELSIUS_URL = "\(CURRENT_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(UNIT_CELSIUS)\(APP_ID)\(API_KEY)"
let CURRENT_FAHRENHEIT_URL = "\(CURRENT_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(UNIT_FAHRENHEIT)\(APP_ID)\(API_KEY)"
var CURRENT_WEATHER_URL = "\(CURRENT_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(UNIT_CELSIUS)\(APP_ID)\(API_KEY)"

let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let FORECAST_EXTRA = "&cnt=10&node=json"
let FORECAST_CELSIUS_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(UNIT_CELSIUS)\(FORECAST_EXTRA)\(APP_ID)\(API_KEY)"
let FORECAST_FAHRENHEIT_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(UNIT_FAHRENHEIT)\(FORECAST_EXTRA)\(APP_ID)\(API_KEY)"
var FORECAST_WEATHER_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(UNIT_CELSIUS)\(FORECAST_EXTRA)\(APP_ID)\(API_KEY)"

let baseToastMessage = NSLocalizedString("Switched unit to", comment: "")
let celsius = "°C"
let fahrenheit = "°F"
var currentUnit = "°C"

typealias DownloadComplete = () -> ()
