//
//  CurrentWeather.swift
//  Forecast
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import UIKit
import Foundation

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _weatherTypeForIcon: String!
    var _currentTemp: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        if let locale = Locale.current.languageCode {
            if locale == "fi" {
                dateFormatter.locale = Locale(identifier: locale)
            } else {
                dateFormatter.locale = Locale(identifier: "en_US")
            }
        }
        let currentDate = dateFormatter.string(from: Date())
        self._date = NSLocalizedString("Today", comment: "") + ", " + currentDate
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var weatherTypeForIcon: String {
        if _weatherTypeForIcon == nil {
            _weatherTypeForIcon = ""
        }
        return _weatherTypeForIcon
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
//Parse data from json file
    func parseDataFrom(dict: Dictionary<String, AnyObject>) {
        if let name = dict["name"] as? String {
            self._cityName = name.capitalized
        }
            
        if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherTypeForIcon = main
                self._weatherType = NSLocalizedString(main, comment: "")
            }
        }
            
        if let main = dict["main"] as? Dictionary<String, AnyObject> {
            if let currentTemperature = main["temp"] as? Int {
                self._currentTemp = String("\(currentTemperature)\(currentUnit)")
            }
        }
    }
}
