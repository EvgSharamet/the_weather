//
//  OneHourInfoView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 18.01.2022.
//

import Foundation
import UIKit



class OneHourInfoView: UIView {
    
    func prepare(weatherData: WeatherDataService.OneDayResponse.Hourly) {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { maker in
            maker.height.equalTo(80)
            maker.width.equalTo(60)
        }
        let dateLabel = UILabel()
        mainStackView.addArrangedSubview(dateLabel)
        
        let weatherIconImageView = UIImageView()
        mainStackView.addArrangedSubview(weatherIconImageView)
        
        let tempLabel = UILabel()
        mainStackView.addArrangedSubview(tempLabel)
     
        //let dateFormatter = DateFormatter() скорее всего прегодится для времени 
        dateLabel.text = String(weatherData.dt)
        
        let urlForImage = URL(string: "https://openweathermap.org/img/wn/\(weatherData.weather.icon)@2x.png")
        let iconData = try? Data(contentsOf: urlForImage!)
        weatherIconImageView.image = UIImage(data: iconData!)
        
        tempLabel.text = String(weatherData.temp) + "°"
    }
}
