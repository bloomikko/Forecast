//
//  DownloadData.swift
//  Forecast
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import Alamofire

var currentWeather = CurrentWeather()
var forecasts = [Forecast]()

//Downloader for data from OpenWeatherMap
class Download {
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let currentURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentURL).responseJSON { response in
            let result = response.result
                    if let dict = result.value as? Dictionary<String, AnyObject> {
                        currentWeather.parseDataFrom(dict: dict)
            }
            completed()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_WEATHER_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast()
                        forecast.parseDataFrom(weatherDict: obj)
                        forecasts.append(forecast)
                    }
                    forecasts.remove(at: 0)
                }
            }
            completed()
        }
        forecasts.removeAll()
    }
}
