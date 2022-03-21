//
//  OneHourInfoView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 18.01.2022.
//

import Foundation
import UIKit

class OneHourInfoView: UIView {
    struct OneHourStringValue {
        let date: String
        let iconString: String
        var icon: UIImage?
        let clouds: String
        let showClouds: Bool
        let temp: String
        let sunsetSunriseView: Bool
    }
    
    let dateLabel = UILabel()
    let weatherIconImageView = UIImageView()
    let cloudsLabel = UILabel()
    let tempLabel = UILabel()
    
    func prepare() {
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalCentering
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(10)
            maker.width.equalToSuperview()
            maker.center.equalToSuperview()
        }
    
        dateLabel.textAlignment = .center
        dateLabel.textColor = .white
        dateLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        mainStackView.addArrangedSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        let centralView = UIView()
        mainStackView.addArrangedSubview(centralView)
        centralView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        centralView.addSubview(weatherIconImageView)
        
        weatherIconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        weatherIconImageView.contentMode = .scaleAspectFit
   
        centralView.addSubview(cloudsLabel)
        cloudsLabel.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        cloudsLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        cloudsLabel.textAlignment = .center
        cloudsLabel.textColor = .cyan
        
        mainStackView.addArrangedSubview(tempLabel)
        tempLabel.textAlignment = .center
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        tempLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    func configure(data: OneHourStringValue){
        dateLabel.text = data.date
        weatherIconImageView.image = data.icon
        if data.showClouds {
            cloudsLabel.text = data.clouds
        }
        tempLabel.text = data.temp
    }
}
