//
//  Forecast.swift
//  Forecast
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import UIKit
import Foundation

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _weatherTypeForIcon: String!
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
    
    var weatherTypeForIcon: String {
        if _weatherTypeForIcon == nil {
            _weatherTypeForIcon = ""
        }
        return _weatherTypeForIcon
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
    
//Parse data from json file
    func parseDataFrom(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Int {
                self._lowTemp = String("\(min)\(currentUnit)")
            }
            
            if let max = temp["max"] as? Int {
                self._highTemp = String("\(max)\(currentUnit)")
            }
        }
        
        if let weather = weatherDict ["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherTypeForIcon = main
                self._weatherType = NSLocalizedString(main, comment: "")
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        if let locale = Locale.current.languageCode {
            if locale == "fi" {
                dateFormatter.locale = Locale(identifier: locale)
            } else {
                dateFormatter.locale = Locale(identifier: "en_US")
            }
        }
        dateFormatter.dateFormat = "cccc d.M."
        return dateFormatter.string(from: self)
    }
}
