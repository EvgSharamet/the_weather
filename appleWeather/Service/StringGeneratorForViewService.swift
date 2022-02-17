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
    
    struct PrecipitationStringValue {
        let weatherType: PrecipitationWidget.WeatherType?
        let textForHeader: String
        let currentValue: String
        let preciptiationText = "за последние сутки"
        let futureValue: String
    }
    
    struct FeelsLikeStringValue {
        let feelsLikeValue: String
        let description: String?
    }
    
    struct HumidityStringValue {
        let humidityValue: String
        let description: String
    }
    
    struct VisibilityStringValue {
        let visibilityValue: String
        let description: String?
    }
    
    struct PressureStringValue {
        let pressureValue: String
        let degreesForGraph: Int
        let aboveNorm: Bool
        let willRise: Bool
        let description = "мм рт. ст."
    }
    
    struct TenDaysStringValue {
        struct OneDayStringValue {
            let icon: UIImage?
            let min: String
            let max: String
            let indicatorRealWidth: Double?
            let leftOffset: Double?
            let dayOfTheWeek: String
        }
        
        let list: [OneDayStringValue]
        let todayPoint: Double
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
    
    func getPrecipitationStringValue(rowData: WeatherDataService.TenDaysResponse) -> PrecipitationStringValue {
        
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
            futurePrecipitation = String(Int(snowFuturePrecipitation)) + " мм ожидается в течение суток"
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
        
        return PrecipitationStringValue(weatherType: weatherType, textForHeader: textForHeader, currentValue: currentPrecipitation ?? "0", futureValue: futurePrecipitation ?? "0 ожидается в течение суток")
    }
    
    func getFeelsLikeStringValue(rowData: WeatherDataService.OneDayResponse) -> FeelsLikeStringValue {
        var description: String?
        
        if rowData.current.feels_like < rowData.current.temp {
            if rowData.current.wind_speed >= 3 {
                description = "По ощущениям холоднее из-за ветра"
            } else {
                if rowData.current.humidity >= 80 {
                    description = "По ощущениям холоднее из-за влажности"
                }
            }
        }
        return FeelsLikeStringValue.init(feelsLikeValue: String(Int(rowData.current.feels_like)) + "°" , description: description)
    }
    
    func getHumidityStringValue(rowData: WeatherDataService.OneDayResponse) -> HumidityStringValue {
        return HumidityStringValue(humidityValue: String(rowData.current.humidity) + "%", description: "Точка росы сейчас — " + String(Int(rowData.current.dew_point)))
    }
    
    func getVisibilityStringValue(rowData: WeatherDataService.OneDayResponse) -> VisibilityStringValue {
        
        var description: String?
        
        switch rowData.current.visibility {
        case 0...501:
            description = "Слабая видимость из-за сильного тумана"
        case 501...1000:
            description = "Видимость ухудшена из-за тумана"
        case 1001...9999:
            description = "Видимость ухудшена из-за дымки"
        case 10000:
            description = "Сейчас ясно"
        default:
            description = nil
        }
        
        var visiblyValue = ""
        if rowData.current.visibility < 1000 {
            visiblyValue = String(rowData.current.visibility) + " м"
        } else {
            visiblyValue = String(Int(rowData.current.visibility / 1000)) + " км"
        }
        
        return VisibilityStringValue(visibilityValue: visiblyValue, description: description)
    }
    
    func getPressureStringValue(rowData: WeatherDataService.OneDayResponse) -> PressureStringValue {
        let pressureValue = String(Int(Float(rowData.current.pressure) * 0.75006375541921)) // 1 hPa = 0.75006375541921 mmHg
        let degressForGraph = (Int(Float(rowData.current.pressure) * 0.75006375541) - 760) * 2 // 760 - reference value // * 2  -
      //   distribution on the graph goes 1 real degree to 2 degrees on graph
        var aboveNorm = true
        if degressForGraph < 0  {
            aboveNorm = false
        }
        let willRise = Bool(rowData.hourly[1].pressure > rowData.hourly[0].pressure)
        return PressureStringValue(pressureValue: pressureValue, degreesForGraph: degressForGraph, aboveNorm: aboveNorm, willRise: willRise)
    }
    
    func getTenDaysStringValue(rowData: WeatherDataService.TenDaysResponse) -> TenDaysStringValue {
        
        var tenDays: [TenDaysStringValue.OneDayStringValue] = []
        
        for rowDay in rowData.list {
      //      let urlForImage = URL(string: "https://openweathermap.org/img/wn/\(rowDay.weather[0].icon))@2x.png")
    //        let iconData = try? Data(contentsOf: urlForImage!)
            let icon = UIImage(named: "arrowWind")
            let globalMin = Int(rowDay.temp.min)
            let globalMax = Int(rowDay.temp.max)
            let dailyAverages = [Int(rowDay.temp.morn), Int(rowDay.temp.day), Int(rowDay.temp.eve), Int(rowDay.temp.night)]
    
            guard let localMin = dailyAverages.min() else { continue }
            guard let localMax = dailyAverages.max() else { continue }
            
            let globalWidth = Double(globalMax - globalMin)
            let width = Double(localMax - localMin)
            
            var indicatorRealWidth: Double?
            var leftOffset: Double?
            
            if globalWidth != Double(0) {
                indicatorRealWidth = Double(width / globalWidth)
                leftOffset = Double( Int(localMin) - globalMin) / globalWidth * 100
            }
            
            print("!!!!!!!!!!!!!!!!!!!!!!!!")
            print(globalMin)
            print(globalMax)
            print(localMin)
            print(localMax)
            print("next")
            
            let date = Date(timeIntervalSince1970: rowDay.dt)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            let dayOfTheWeek = dateFormatter.string(from: date).capitalized
            
            tenDays.append(TenDaysStringValue.OneDayStringValue(icon: icon, min: String("\(globalMin)°"), max: String("\(globalMax)°"), indicatorRealWidth: indicatorRealWidth, leftOffset: leftOffset, dayOfTheWeek: dayOfTheWeek))
        }
        return TenDaysStringValue.init(list: tenDays, todayPoint: 0) // больше не могу, посчитай его потом
    }
}
