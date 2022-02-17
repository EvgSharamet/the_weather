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
    
    struct OneDayStringValue {
        let icon: UIImage?
        let min: String
        let max: String
        let leftOffset: Double?
        let distributionIndicatorWidth: Double?
        let dayOfTheWeek: String
    }
    
    let distributionIndicatorView = UIView()
    let distributionAxisView = UIView()
    let weatherIconImageView = UIImageView()
    let dateLabel = UILabel()
    let minTempLabel = UILabel()
    let maxTempLabel = UILabel()
    let currentPointView = UIImageView()
    
    func prepare() {
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.distribution  = .fillEqually
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        mainStackView.addArrangedSubview(dateLabel)
  
        weatherIconImageView.contentMode = .scaleAspectFit
        mainStackView.addArrangedSubview(weatherIconImageView)
        weatherIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-20)
            make.bottom.equalToSuperview().inset(-20)
        }
        
        mainStackView.addArrangedSubview(minTempLabel)
        minTempLabel.textAlignment = .center
        let distributionView = UIView()
        mainStackView.addArrangedSubview(distributionView)
        distributionView.addSubview(distributionAxisView)
        distributionAxisView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.08)
            make.center.equalToSuperview()
            make.width.equalTo(100)
        }
        
        distributionAxisView.layer.cornerRadius = 2
        distributionAxisView.layer.masksToBounds = true
    
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        distributionAxisView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        distributionAxisView.addSubview(distributionIndicatorView)
        distributionIndicatorView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        distributionIndicatorView.layer.cornerRadius = 2
        distributionIndicatorView.backgroundColor = .cyan
        
        self.addSubview(currentPointView)
        currentPointView.snp.makeConstraints { make in
            make.center.centerX.equalTo(distributionAxisView)
            make.height.equalTo(distributionAxisView)
            make.width.equalTo(6)
        }
        currentPointView.image = UIImage(named: "pointUVI")
    
        mainStackView.addArrangedSubview(maxTempLabel)
        maxTempLabel.textAlignment = .center
    }

    func configure(data: OneDayStringValue) {
        weatherIconImageView.image = data.icon
        dateLabel.text = data.dayOfTheWeek
        minTempLabel.text = data.min
        maxTempLabel.text = data.max
        
        guard let leftOffset = data.leftOffset else {
            return
        }
        guard let distributionIndicatorWidth = data.distributionIndicatorWidth else {
            return
        }
        
        distributionIndicatorView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(leftOffset)
            make.width.equalToSuperview().multipliedBy(Swift.max(Swift.min(distributionIndicatorWidth, 1.0), 0.1))
        }
    }
}

