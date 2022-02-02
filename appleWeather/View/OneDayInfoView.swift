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
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
        
       let dateLabel = UILabel()
        mainStackView.addArrangedSubview(dateLabel)
        dateLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.2)
        }
        
        let weatherIconImageView = UIImageView()
        weatherIconImageView.contentMode = .scaleAspectFill
        mainStackView.addArrangedSubview(weatherIconImageView)
        weatherIconImageView.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.18)
        }
        
        let minTempLabel = UILabel()
        mainStackView.addArrangedSubview(minTempLabel)
        minTempLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.2)
        }
        
        let maxTempLabel = UILabel()
        mainStackView.addArrangedSubview(maxTempLabel)
        maxTempLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.2)
        }
        
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
