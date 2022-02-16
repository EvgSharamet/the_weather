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
    
     let distributionIndicatorView = UIView()
    
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
        
        let distributionAxisView = UIView()
        distributionView.addSubview(distributionAxisView)
        distributionAxisView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.08)
            make.center.equalToSuperview()
            make.width.equalTo(100)//.//inset(-20)
        }
        
        distributionAxisView.layer.cornerRadius = 2
   //     distributionAxisView.layer.masksToBounds = true
    
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        distributionAxisView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        distributionAxisView.addSubview(distributionIndicatorView)
        distributionIndicatorView.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        let globalMin = Int(weatherData.temp.min)
        let globalMax = Int(weatherData.temp.max)
        var min = Int(weatherData.temp.eve)
        var max = Int(weatherData.temp.morn)
        if min > max {
            min = Int(weatherData.temp.morn)
            max = Int(weatherData.temp.eve)
        }
        print(globalMin , globalMax)
        print ( min , max)
        print("next")
        
        let globalWidth = Double(globalMax - globalMin)
        let width = Double(max - min) + 0.01
        let indicatorRealWidth = width / globalWidth * 100 + 10 //+ 10 чтобы отображалось значение, если минимальная и максимальная локальные точки равны
        let leftOffset = Double(min - globalMin) / globalWidth * 100
        //print( leftOffset)
        
        
        distributionIndicatorView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(leftOffset)
            make.width.equalTo(indicatorRealWidth)
        }
        
        distributionIndicatorView.backgroundColor = .blue
        
    
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
