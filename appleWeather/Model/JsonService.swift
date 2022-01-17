//
//  jsonService.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 14.01.2022.
//

import Foundation
import CoreLocation

class JsonService {
    //MARK: - types
    
    struct Error: Swift.Error {
        let info: String
    }
    
    struct OneDayResponse: Codable {
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        
        struct Hourly: Codable {
            let dt: Int
            let temp: Float
            let weather: [Weather]
        }
        
        struct Current: Codable {
            let dt: Int
            let sunrise: Int
            let sunset: Int
            let temp: Float
            let feels_like: Float
            let pressure: Int
            let humidity: Int //влажность
            let dew_point: Float // точка росы
            let uvi: Int // уфи
            let clouds: Int
            let visibility: Int
            let wind_speed: Float
            let wind_deg: Int
         //   let wind_gust: Float // не получается превратить
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
            let min: Float
            let max: Float
        }
        
        struct Day: Codable {
            let dt: Int
            let temp: Temp
            let humidity: Int
            let weather: [Weather]
        }

        let list: [Day]
    }

    struct OneDayData {
        let description: OneDayResponse
        let hourly: [JsonService.OneDayResponse.Weather]
    }
    
    typealias DayInformationRequestResult = Result<OneDayData, Swift.Error>
    typealias DayInformationRequestResultHandler = (DayInformationRequestResult) -> Void
    
    typealias TenDaysInformationRequestResult = Result<TenDaysResponse, Swift.Error>
    typealias TenDaysInformationRequestResultHandler = (TenDaysInformationRequestResult) -> Void
    
    //MARK: - data
    
    static let shared = JsonService()
    
    //MARK: - internal functions
    func requestByCurrentDay(place: String, handler: @escaping DayInformationRequestResultHandler) {

        CLGeocoder().geocodeAddressString(place) { placemark, error in
            guard let location = placemark?.first?.location?.coordinate else {
                let err = error ?? Error(info: "no location \(place)")
                handler(.failure(err))
                return
            }
            do {
                let weatherData = try self.getCurrentDayData(location)
                handler(.success(weatherData))
            } catch {
                handler(.failure(error))
            }
        }
    }
    
    func requestByTenDays(place: String, handler: @escaping TenDaysInformationRequestResultHandler) {

        CLGeocoder().geocodeAddressString(place) { placemark, error in
            guard let location = placemark?.first?.location?.coordinate else {
                let err = error ?? Error(info: "no location \(place)")
                handler(.failure(err))
                return
            }
            do {
                let weatherData = try self.getDataForTenDays(location)
                handler(.success(weatherData))
            } catch {
                handler(.failure(error))
            }
        }
    }
    
    //MARK: - private functions
    
    private func getDataForTenDays(_ location:CLLocationCoordinate2D ) throws -> TenDaysResponse {
        let decoder = JSONDecoder()
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(location.latitude)&lon=\(location.longitude)&lang=ru&cnt=10&units=metric&appid=167ec7c4487c8b004df1c9b138fb6600")

        else {
            throw Error(info: "can't get url")
        }
        print("URL == \(url)")

        
        guard let jsonString = try? String(contentsOf: url, encoding:.utf8) else {
            throw Error(info: "can't decode url")
        }
        
        let jsonData = Data(jsonString.utf8)
        guard let answer = try? decoder.decode(TenDaysResponse.self, from: jsonData) else {
            throw Error(info: "can't decode Response")
        }

        return answer
    }
     
    private func getCurrentDayData(_ location:CLLocationCoordinate2D ) throws -> OneDayData {
        let decoder = JSONDecoder()
        guard let url = URL( string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(location.latitude)&lon=\(location.longitude)&lang=ru&exclude=minutely,daily&units=metric&appid=167ec7c4487c8b004df1c9b138fb6600")
        else {
            throw Error(info: "can't get url")
        }
        
        guard let jsonString = try? String(contentsOf: url, encoding:.utf8) else {
            throw Error(info: "can't decode url")
        }
        
        let jsonData = Data(jsonString.utf8)
        
        guard let answer = try? decoder.decode(OneDayResponse.self, from: jsonData) else {
            throw Error(info: "can't decode Response")
        }
        
        let rawDataToday = answer.hourly.dropLast(23)
        var weatherInfoToday: [JsonService.OneDayResponse.Weather] = []

        for item in rawDataToday {
            weatherInfoToday.append(JsonService.OneDayResponse.Weather( description: item.weather.first?.description ?? "missing", icon: item.weather.first?.icon ?? "01n"))
        }
        return OneDayData(description: answer, hourly: weatherInfoToday )
   }
}
