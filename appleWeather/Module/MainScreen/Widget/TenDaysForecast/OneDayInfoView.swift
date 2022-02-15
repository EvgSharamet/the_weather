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
        weatherIconImageView.contentMode = .scaleAspectFit
        mainStackView.addArrangedSubview(weatherIconImageView)
        weatherIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-20)
            make.bottom.equalToSuperview().inset(-20)
        }
        
        let minTempLabel = UILabel()
        mainStackView.addArrangedSubview(minTempLabel)
        minTempLabel.textAlignment = .center
        
        let distributionView = UIView()
        mainStackView.addArrangedSubview(distributionView)
        
        let distributionIndicatorView = UIView()
        distributionView.addSubview(distributionIndicatorView)
        distributionIndicatorView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.08)
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(-20)
        }
        
        distributionIndicatorView.layer.cornerRadius = 2
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        distributionIndicatorView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        distributionIndicatorView.layer.masksToBounds = true
        
        let maxTempLabel = UILabel()
        mainStackView.addArrangedSubview(maxTempLabel)
        maxTempLabel.textAlignment = .center
        
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
