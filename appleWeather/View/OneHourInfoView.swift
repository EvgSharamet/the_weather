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
        mainStackView.backgroundColor = .blue.withAlphaComponent(0.6)
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalCentering
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    
        let dateLabel = UILabel()
        mainStackView.addArrangedSubview(dateLabel)
        
        let weatherIconImageView = UIImageView()
        mainStackView.addArrangedSubview(weatherIconImageView)
        
        let tempLabel = UILabel()
        mainStackView.addArrangedSubview(tempLabel)
     
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateLabel.text = dateFormatter.string(from: weatherData.dt)
        
        let urlForImage = URL(string: "https://openweathermap.org/img/wn/\(weatherData.weather[0].icon)@2x.png")
        let iconData = try? Data(contentsOf: urlForImage!)
        weatherIconImageView.image = UIImage(data: iconData!)
        
        tempLabel.text = String(weatherData.temp) + "°"
    }
}
