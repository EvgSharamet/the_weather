//
//  locationController.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 14.01.2022.
//

import Foundation
import SnapKit
import UIKit
import CoreLocation

class LocationController: UIViewController, CLLocationManagerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()

     /*   JsonService.shared.requestByTenDays(place: "Калининград") { result in
            switch result {
                case .success(let weatherData):
                    print(weatherData)
                case .failure(_):
                    let alert = UIAlertController(title: "Warning", message: "Weather data didn't load", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
        }
        */
        
        WeatherDataService.shared.requestByCurrentDay(place: "Калининград") { result in
            switch result {
                case .success(let weatherData):
                    print("SUCESS")
                case .failure(_):
                    let alert = UIAlertController(title: "Warning", message: "Weather data didn't load", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
        }
        locationManager.requestWhenInUseAuthorization()
    }
}



