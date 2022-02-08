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
        let numberValue: String
        let textValue: String
        let description: String
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
        
        let currentUVI = uviValuesPerDay[0]
        let maxUVI = uviValuesPerDay.max()
        guard let maxUVI = maxUVI else {
            return UVIndexStringValue(numberValue: String(rowData.current.uvi), textValue: textValue, description: "")
        }

        if currentUVI >= maxUVI {
            description = "Индекс останется \(textValue) до конца дня"
        } else {
            description = "Индекс повысится до \(maxUVI) в течение дня"
        }
        
        return UVIndexStringValue(numberValue:String(rowData.current.uvi), textValue: textValue, description: description)
    }
}
