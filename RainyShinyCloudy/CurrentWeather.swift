//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Mikko Rouru on 11.6.2017.
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import UIKit

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
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
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    func parseDataFrom(dict: Dictionary<String, AnyObject>) {
        print(dict)
            if let name = dict["name"] as? String {
                self._cityName = name.capitalized
                print("test: \(self._cityName)")

            }
            
            if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                if let main = weather[0]["main"] as? String {
                    self._weatherType = main.capitalized
                }
            }
            
            if let main = dict["main"] as? Dictionary<String, AnyObject> {
                if let currentTemperature = main["temp"] as? Double {
                    var kelvinToCelsius = currentTemperature - 273.15
                    kelvinToCelsius.round()
                    let intCurrent = Int(kelvinToCelsius)
                    self._currentTemp = "\(intCurrent)°"
                }
            }
        }
    }
