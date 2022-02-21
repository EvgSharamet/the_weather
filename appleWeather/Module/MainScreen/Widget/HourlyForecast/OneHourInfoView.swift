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
        let icon: UIImage?
        let clouds: String
        let showClouds: Bool
        let temp: String
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
            maker.edges.equalToSuperview()
        }
    
        dateLabel.textAlignment = .center
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
            make.top.equalToSuperview().inset(10)
            make.height.equalToSuperview().inset(-5)
            make.width.equalToSuperview().inset(-5)
            make.center.equalToSuperview()
        }
        
        weatherIconImageView.contentMode = .scaleAspectFill
        weatherIconImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        centralView.addSubview(cloudsLabel)
        cloudsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(14)
            make.width.equalToSuperview()
        }
        cloudsLabel.font = cloudsLabel.font.withSize(14)
        cloudsLabel.textAlignment = .center
        cloudsLabel.textColor = .cyan
        
        mainStackView.addArrangedSubview(tempLabel)
        tempLabel.textAlignment = .center
        tempLabel.font = tempLabel.font.withSize(15)
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
