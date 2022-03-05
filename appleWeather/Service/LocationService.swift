//
//  locationService.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 14.01.2022.
//
import Foundation
import CoreLocation

class LocationService {
    typealias RequestResult = Result<Coordinate, Error>
    typealias RequestHandler = (RequestResult) -> Void
    
    struct Coordinate {
        let latitude: Double
        let longitude: Double
    }
    
    static let shared = LocationService()
    
    private let queue = DispatchQueue(label: "LocationService.queue", qos: .default)
    private var lastResult: Result<Coordinate, Error>?
    private var requestHandlers = [RequestHandler]()
    private var locationManagerWrapper: LocationManagerWrapper?
    
    func requestLocation(requestHandler: @escaping RequestHandler) {
        queue.sync {
            if let lastResult = self.lastResult {
                requestHandler(lastResult)
                return
            }
            self.requestHandlers.append(requestHandler)
        }
    }
    
    private init() {
        let lmw = LocationManagerWrapper()
        lmw.run { [weak self] result in
            guard let self = self else { return }
            self.queue.sync {
                let localResult = result.toLocationServiceRequestResult()
                self.lastResult = localResult
                self.requestHandlers.forEach {
                    $0(localResult)
                }
                self.requestHandlers.removeAll()
                self.locationManagerWrapper = nil
            }
        }
        locationManagerWrapper = lmw
    }
}

private class LocationManagerWrapper: NSObject, CLLocationManagerDelegate {
    typealias RequestResult = Result<CLLocationCoordinate2D, Error>
    typealias RequestHandler = (RequestResult) -> Void
    
    private let manager = CLLocationManager()
    private var handler: RequestHandler?
    
    override init() {
        super.init()
    }
    
    func run(handler: @escaping RequestHandler) {
        self.handler = handler
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            handler?(.success(location.coordinate))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handler?(.failure(error))
    }
}

private extension LocationManagerWrapper.RequestResult {
    func toLocationServiceRequestResult() -> LocationService.RequestResult {
        switch self {
        case .success(let coordinate):
            return .success(.init(latitude: coordinate.latitude, longitude: coordinate.longitude))
        case .failure(let error):
            return .failure(error)
        }
    }
}

