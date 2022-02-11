//
//  OneDayInfoView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 20.01.2022.
//

import Foundation
import SnapKit
import UIKit



class OneDayInfoView: UIView {
    
    func prepare(weatherData: WeatherDataService.TenDaysResponse.Day) {
       
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.distribution  = .fillEqually
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
       let dateLabel = UILabel()
        mainStackView.addArrangedSubview(dateLabel)
  
        
        let weatherIconImageView = UIImageView()
        weatherIconImageView.contentMode = .scaleAspectFill
        mainStackView.addArrangedSubview(weatherIconImageView)
        
        let minTempLabel = UILabel()
        mainStackView.addArrangedSubview(minTempLabel)
        
        let maxTempLabel = UILabel()
        mainStackView.addArrangedSubview(maxTempLabel)
        
        let date = Date(timeIntervalSince1970: weatherData.dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateLabel.text = dateFormatter.string(from: date).capitalized
        
        let urlForImage = URL(string: "https://openweathermap.org/img/wn/\(weatherData.weather[0].icon)@2x.png")
        let iconData = try? Data(contentsOf: urlForImage!)
        weatherIconImageView.image = UIImage(data: iconData!)
        
        minTempLabel.text = String(Int(weatherData.temp.min)) + "°"
        maxTempLabel.text = String(Int(weatherData.temp.max)) + "°"
    }
}
