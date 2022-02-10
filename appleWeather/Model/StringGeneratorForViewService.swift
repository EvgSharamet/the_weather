//
//  StringGeneratorForViewService.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 07.02.2022.
//

import Foundation
import SnapKit
import UIKit



class StringGeneratorForViewService {
    
    struct UVIndexStringValue {
        let number: Float
        let numberValue: String
        let textValue: String
        let description: String
    }
    
    struct SunriseStringValue {
        let sunrise: Date
        let sunset: Date
        let sunriseValue: String
        let sunsetValue: String
    }
    
    struct WindStringValue {
         let windSpeed: String
        let windMeasure = "м/с"
         let windDeg: Int
    }
    
    struct precipitationStringValue {
        let weatherType: PrecipitationWidget.WeatherType?
        let textForHeader: String
        let currentValue: String
        let preciptiationText = "за последние сутки"
        let futureValue: String
    }
    
    static let shared = StringGeneratorForViewService()
    
    func  getUVIndexStringValue(rowData: WeatherDataService.OneDayResponse)  -> UVIndexStringValue {
        
        var textValue = ""
        
        switch rowData.current.uvi {
        case 0...2:
            textValue = "Низкий"
        case 3...5:
            textValue = "Умеренный"
        case 6...7:
            textValue = "Высокий"
        case 8...10:
            textValue = "Очень высокий"
        case 11...15:
            textValue = "Чрезмерный"
        default:
            textValue = "Значение отсутствует"
        }
        
        var description = ""
        
        var uviValuesPerDay: [Float] = []
        for i in rowData.hourly {
            uviValuesPerDay.append(i.uvi)
        }
        uviValuesPerDay = uviValuesPerDay.dropLast(12)
       
        
        let currentUVI = uviValuesPerDay[0]
        guard let maxUVI =  uviValuesPerDay.max() else {
            return UVIndexStringValue( number: rowData.current.uvi , numberValue: String(rowData.current.uvi), textValue: textValue, description: "")
        }

        if currentUVI >= maxUVI {
            description = "Индекс \(textValue) до конца дня"
        } else {
            description = "Индекс повысится до \(maxUVI) в течение дня"
        }
        
        return UVIndexStringValue(number: rowData.current.uvi, numberValue:String(rowData.current.uvi), textValue: textValue, description: description)
    }
    
    func  getSunriseStringValue(rowData: WeatherDataService.OneDayResponse)  -> SunriseStringValue {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM"
        return SunriseStringValue(sunrise: rowData.current.sunrise, sunset: rowData.current.sunset, sunriseValue: dateFormatter.string(from: rowData.current.sunrise), sunsetValue: dateFormatter.string(from: rowData.current.sunset))
    }
    
    func getWindStringValue(rowData: WeatherDataService.OneDayResponse) -> WindStringValue {
        let windSpeed = "\(Int(rowData.current.wind_speed))"
        return WindStringValue(windSpeed: windSpeed, windDeg: rowData.current.wind_deg)
    }
    
    func getPrecipitationStringValue(rowData: WeatherDataService.TenDaysResponse) -> precipitationStringValue {
        
        var weatherType: PrecipitationWidget.WeatherType?
        var currentPrecipitation: String?
        var futurePrecipitation: String?
        
        if let rainCurrentPrecipitation = rowData.list[0].rain {
            weatherType = .rain
            currentPrecipitation = String(Int(rainCurrentPrecipitation)) + " мм"
        }
        
        if let snowCurrentPrecipitation = rowData.list[0].snow {
            if let _ = weatherType {
                weatherType = .rainWithSnow
            } else {
                weatherType = .snow
            }
            currentPrecipitation = String(Int(snowCurrentPrecipitation)) + " мм"
        }
        
        
        if let rainCurrentPrecipitation = rowData.list[0].rain {
            weatherType = .rain
            currentPrecipitation = String(Int(rainCurrentPrecipitation)) + " мм"
        }
        
        if let snowCurrentPrecipitation = rowData.list[0].snow {
            if let _ = weatherType {
                weatherType = .rainWithSnow
            } else {
                weatherType = .snow
            }
            currentPrecipitation = String(Int(snowCurrentPrecipitation)) + " мм"
        }
        
        if let rainFuturePrecipitation = rowData.list[1].rain {
            futurePrecipitation = String(Int(rainFuturePrecipitation)) + " мм ожидается в течение суток"
        }
        
        if let snowFuturePrecipitation = rowData.list[1].snow {
            currentPrecipitation = String(Int(snowFuturePrecipitation)) + " мм ожидается в течение суток"
        }
        
        var textForHeader = ""
        
        switch weatherType {
        case .snow:
            textForHeader = "❄️ SNOW"
        case .rain:
            textForHeader = "☔️ RAIN"
        case .rainWithSnow:
            textForHeader = "💧 RAIN WITH SNOW"
        default:
            textForHeader = "💧 PRECIPITATION"
        }
        
        
        return precipitationStringValue(weatherType: weatherType, textForHeader: textForHeader, currentValue: currentPrecipitation ?? "0", futureValue: futurePrecipitation ?? "0 мм ожидается в течение суток")
    }
}
