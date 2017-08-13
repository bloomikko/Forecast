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
    @IBOutlet weak var unitButton: UIButton!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var forecast: Forecast!
    
    var refresher: UIRefreshControl!
    
//Location services, asks for user's permission to use GPS for weather data
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        tableView.delegate = self
        tableView.dataSource = self
        
        refresher = UIRefreshControl()
        refresher.tintColor = UIColor.white
        refresher.addTarget(self, action: #selector(self.updateData), for: .valueChanged)
        tableView.refreshControl = refresher
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            errorView.isHidden = true
        } else {
            errorView.isHidden = false
            errorLabel.text = NSLocalizedString("Location services are required for using the app. Enable them in Settings app.", comment: "")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locationManager.location
        Location.sharedInstance.latitude = currentLocation.coordinate.latitude
        Location.sharedInstance.longitude = currentLocation.coordinate.longitude
        
        if Connectivity.isConnectedToInternet() {
            updateData()
        } else {
            errorView.isHidden = false
            errorLabel.text = NSLocalizedString("Check your Internet connection. Unable to fetch data.", comment: "")
            tryAgainButton.isHidden = false
        }
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
            if !self.refresher.isRefreshing && forecasts.count > 0 {
                let forecast = forecasts[indexPath.row]
                cell.configureCell(forecast: forecast)
            }
            return cell
        } else {
            return WeatherCell()
        }
    }
    
//Button action for switching between celsius and fahrenheit
    @IBAction func unitButtonPressed(_ sender: Any) {
        if !self.refresher.isRefreshing {
            if (CURRENT_WEATHER_URL == CURRENT_CELSIUS_URL) {
                CURRENT_WEATHER_URL = CURRENT_FAHRENHEIT_URL
                FORECAST_WEATHER_URL = FORECAST_FAHRENHEIT_URL
                currentUnit = fahrenheit
            } else {
                CURRENT_WEATHER_URL = CURRENT_CELSIUS_URL
                FORECAST_WEATHER_URL = FORECAST_CELSIUS_URL
                currentUnit = celsius
            }
            let toastMessage = baseToastMessage + " " + currentUnit
            showUnitToast(message: toastMessage)
            updateData()
        }
    }
    
//Button for trying again connecting to Internet
    @IBAction func tryAgainButtonPressed(_ sender: Any) {
        if Connectivity.isConnectedToInternet() {
            updateData()
            errorView.removeFromSuperview()
        } else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: errorLabel.center.x - 10, y: errorLabel.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: errorLabel.center.x + 10, y: errorLabel.center.y))
            errorLabel.layer.add(animation, forKey: "position")
        }
    }
    
//Toast for switching between celsius/fahrenheit
    func showUnitToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height/2 - 50, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Blogger Sans", size: 20.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
            self.unitButton.isUserInteractionEnabled = false
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            self.unitButton.isUserInteractionEnabled = true
        })
    }
    
//Data and UI updates
    func updateData() {
        locationManager.startUpdatingLocation()
        self.refresher.endRefreshing()
        Download().downloadWeatherDetails {
            self.updateCurrentWeather()
            Download().downloadForecastData {
                self.tableView.reloadData()
            }
        }
        forecasts.removeAll()
        let updateString = NSLocalizedString("Updating...", comment: "")
        let attributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Blogger Sans", size: 13.0)]
        self.refresher.attributedTitle = NSAttributedString(string: updateString, attributes: attributes)
        locationManager.stopUpdatingLocation()
    }
    
    func updateCurrentWeather() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherTypeForIcon)
    }
}
