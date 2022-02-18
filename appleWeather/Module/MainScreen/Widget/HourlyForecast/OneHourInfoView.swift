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
        mainStackView.distribution = .equalCentering
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    
        let dateLabel = UILabel()
        dateLabel.textAlignment = .center
        mainStackView.addArrangedSubview(dateLabel)
        dateLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.25)
        }
        
        let weatherIconImageView = UIImageView()
        weatherIconImageView.contentMode = .scaleAspectFill
        mainStackView.addArrangedSubview(weatherIconImageView)
        weatherIconImageView.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.5)
        }
        
        let tempLabel = UILabel()
        mainStackView.addArrangedSubview(tempLabel)
        tempLabel.textAlignment = .center
        tempLabel.font = tempLabel.font.withSize(15)
        tempLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.25)
        }
     
        let date = Date(timeIntervalSince1970: weatherData.dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateLabel.text = dateFormatter.string(from: date)
       
        if let urlForImage = URL(string: "https://openweathermap.org/img/wn/\(weatherData.weather[0].icon)@2x.png") {
            if let iconData = try? Data(contentsOf: urlForImage) {
                weatherIconImageView.image = UIImage(data:iconData)
            }
        }
        tempLabel.text = String(Int(weatherData.temp)) + "°"
    }
}
