//
//  WeatherViewController.swift
//  Forecast
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var forecast: Forecast!
    var download: Download!
 
//Location services, asks for user permission to use GPS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            updateData()
    }
 
//Table view configuration
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
//Button for switching between celsius and fahrenheit
    @IBAction func unitButtonPressed(_ sender: Any) {
        if (CURRENT_WEATHER_URL == CURRENT_CELSIUS_URL) {
            CURRENT_WEATHER_URL = CURRENT_FAHRENHEIT_URL
            FORECAST_WEATHER_URL = FORECAST_FAHRENHEIT_URL
            currentUnit = fahrenheit
        } else {
            CURRENT_WEATHER_URL = CURRENT_CELSIUS_URL
            FORECAST_WEATHER_URL = FORECAST_CELSIUS_URL
            currentUnit = celsius
        }
        updateData()
    }
    
//Data updates
    func updateData() {
        Download().downloadWeatherDetails {
            self.updateMainUI()
            Download().downloadForecastData {
                self.tableView.reloadData()
            }
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
}
