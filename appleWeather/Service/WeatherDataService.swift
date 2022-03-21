//
//  jsonService.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 14.01.2022.
//

import Foundation
import CoreLocation
import UIKit

class WeatherDataService {
    //MARK: - types
    struct Error: Swift.Error {
        let info: String
    }
    
    struct OneDayResponse: Codable {
        struct Weather: Codable {
            private enum CodingKeys: String, CodingKey { case description; case icon }
            let description: String
            let icon: String
            
            var iconUIImage: UIImage?
        }
        
        struct Hourly: Codable {
            let dt: Double
            let temp: Float
            let pressure: Int
            let clouds: Int
            let weather: [Weather]
            let uvi: Float
            let rain: Rain?
            let snow: Snow?

            struct Rain: Codable {
                private enum CodingKeys : String, CodingKey { case h1 = "1h"}
                let h1: Double
            }
            struct Snow: Codable {
                private enum CodingKeys : String, CodingKey { case h1 = "1h"}
                let h1: Double
            }
        }
        
        struct Current: Codable {
            let dt: Double
            let sunrise: Double
            let sunset: Double
            let temp: Float
            let feels_like: Float
            let pressure: Int
            let humidity: Int
            let dew_point: Float
            let uvi: Float
            let clouds: Int
            let visibility: Int
            let wind_speed: Float
            let wind_deg: Int
            let wind_gust: Float?
        }
        let current: Current
        let hourly: [Hourly]
    }
    
    struct TenDaysResponse: Codable {
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }

        struct Temp: Codable {
            let day: Float
            let min: Float
            let max: Float
            let night: Float
            let eve: Float
            let morn: Float
        }
        
        struct Day: Codable {
            let dt: Double
            let sunrise: Double
            let sunset: Double
            let temp: Temp
            let humidity: Int
            let weather: [Weather]
            let clouds: Int
            let rain: Float?
            let snow: Float?
        }
        
        struct City: Codable {
            let name: String
        }
        
        let city: City
        let list: [Day]
    }
    
    struct Coordinate {
        let latitude: Double
        let longitude: Double
    }
    
    typealias DayInformationRequestResult = Result<OneDayResponse, Swift.Error>
    typealias DayInformationRequestResultHandler = (DayInformationRequestResult) -> Void
    
    typealias TenDaysInformationRequestResult = Result<TenDaysResponse, Swift.Error>
    typealias TenDaysInformationRequestResultHandler = (TenDaysInformationRequestResult) -> Void
    
    //MARK: - data
    
    static let shared = WeatherDataService()
    
    //MARK: - internal functions
    func requestByCurrentDay(location: Coordinate, handler: @escaping DayInformationRequestResultHandler) {
            do {
                let weatherData = try self.getCurrentDayData(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                handler(.success(weatherData))
            } catch {
                handler(.failure(error))
            }
    }
    
    func requestByTenDays(location: Coordinate, handler: @escaping TenDaysInformationRequestResultHandler) {
            do {
                let weatherData = try self.getDataForTenDays(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                handler(.success(weatherData))
            } catch {
                handler(.failure(error))
            }
    }
    
    //MARK: - private functions
    
    private func getDataForTenDays(_ location: CLLocationCoordinate2D ) throws -> TenDaysResponse {
        let decoder = JSONDecoder()
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(location.latitude)&lon=\(location.longitude)&lang=ru&cnt=10&units=metric&appid=167ec7c4487c8b004df1c9b138fb6600")
        else {
            throw Error(info: "can't get url")
        }
        print( url)
        
        guard let jsonString = try? String(contentsOf: url, encoding:.utf8) else {
            throw Error(info: "can't decode url")
        }
        
        let jsonData = Data(jsonString.utf8)
        guard let answer = try? decoder.decode(TenDaysResponse.self, from: jsonData) else {
            throw Error(info: "can't decode Response")
        }
        return answer
    }
     
    private func getCurrentDayData(_ location:CLLocationCoordinate2D ) throws -> OneDayResponse {
        let decoder = JSONDecoder()
        guard let url = URL( string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(location.latitude)&lon=\(location.longitude)&lang=ru&exclude=minutely,daily&units=metric&appid=167ec7c4487c8b004df1c9b138fb6600")
             
        else {
            throw Error(info: "can't get url")
        }
        print( url)
        
        guard let jsonString = try? String(contentsOf: url, encoding:.utf8) else {
            throw Error(info: "can't decode url")
        }
        
        let jsonData = Data(jsonString.utf8)
        
        guard let answer = try? decoder.decode(OneDayResponse.self, from: jsonData) else {
            throw Error(info: "can't decode Response")
        }
        
        return OneDayResponse(current: answer.current ,hourly: answer.hourly.dropLast(23))
   }
}

protocol Iconable {
    var icon: String {get}
    var iconImage: UIImage? {get set}
}
