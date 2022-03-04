//
//  locationService.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 14.01.2022.
//
import Foundation
import CoreLocation


class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared = LocationService()
    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func local () {
        self.locationManager(manager, locations: [] )
    }
    
    func locationManager(_ manager: CLLocationManager, locations: [CLLocation]) {
        if let location = locations.last {
          print( "Lat : \(location.coordinate.latitude) , Lng : \(location.coordinate.longitude)")
        }
    }
}
