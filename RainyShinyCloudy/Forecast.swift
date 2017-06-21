//
//  Forecast.swift
//  Forecast
//
//  Created by Mikko Rouru on 11.6.2017.
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import UIKit
import Foundation

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    func parseDataFrom(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Int {
                self._lowTemp = String("\(min)°")
            }
            
            if let max = temp["max"] as? Int {
                self._highTemp = String("\(max)°")
            }
        }
        
        if let weather = weatherDict ["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en")
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "EEEE dd.M."
        return dateFormatter.string(from: self)
    }
}
