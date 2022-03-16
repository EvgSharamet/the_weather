//
//  Sunrise.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 26.01.2022.
//

import Foundation
import SnapKit
import UIKit


class SunriseWidget: ViewWithRoundedCorner {
    struct SunriseStringValue {
        let sunrise: Double
        let sunset: Double
        let sunriseValue: String
        let sunsetValue: String
    }
    
    let sunriseLabel = UILabel()
    let sunsetLabel = UILabel()
    let indicatorView = UIView()
    let indicatorPointView = UIView()
    
    func prepare() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(10)
            maker.bottom.equalToSuperview().inset(10)
            maker.left.equalToSuperview().inset(15)
            maker.right.equalToSuperview().inset(15)
        }
        stackView.addArrangedSubview(sunriseLabel)
        
        sunriseLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.2)
        }
        
        sunriseLabel.font = sunriseLabel.font.withSize(30)
        sunriseLabel.textColor = .white
        
        stackView.addArrangedSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        indicatorView.layer.cornerRadius = 4
        indicatorView.contentMode = .scaleAspectFit
        indicatorView.layer.masksToBounds = true
    
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        indicatorView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        let beforeSunriseView =  UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        beforeSunriseView.alpha = 0.5
        indicatorView.addSubview(beforeSunriseView)
        beforeSunriseView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.left.equalToSuperview()
        }
        let afterSunsetView =  UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        afterSunsetView.alpha = 0.5
        indicatorView.addSubview(afterSunsetView)
        afterSunsetView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.right.equalToSuperview()
        }
    
        indicatorPointView.backgroundColor = .white
        indicatorPointView.layer.cornerRadius = 4.5
        self.addSubview(indicatorPointView)
        indicatorPointView.snp.makeConstraints { maker in
            maker.height.equalTo(9)
            maker.width.equalTo(9)
            maker.centerY.equalTo(indicatorView)
        }
        indicatorPointView.layer.shadowOffset = .zero
        indicatorPointView.layer.shadowOpacity = 0.7
        indicatorPointView.layer.shadowRadius = 5
        indicatorPointView.layer.shadowColor = UIColor.white.cgColor
        indicatorPointView.layer.masksToBounds = false
        stackView.addArrangedSubview(sunsetLabel)
        sunsetLabel.font = sunsetLabel.font.withSize(17)
        sunsetLabel.textColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        indicatorPointView.layer.shadowPath = UIBezierPath(ovalIn: indicatorPointView.bounds.insetBy(dx: -5, dy: -5)).cgPath
    }
    
    func configure(data: SunriseStringValue) {
        sunriseLabel.text = data.sunriseValue
        sunsetLabel.text = data.sunsetValue
        indicatorPointView.snp.makeConstraints { make in
            make.right.equalTo(indicatorView).multipliedBy(0.5)
        }
    }
}


/*
class SunriseWidget: ViewWithRoundedCorner {
    struct SunriseStringValue {
        let sunrise: Double
        let sunset: Double
        let sunriseValue: String
        let sunsetValue: String
    }
    
    let sunriseLabel = UILabel()
    let sunsetLabel = UILabel()
    let sunPathChart = SunPathView()
    
    func prepare() {
        sunPathChart.backgroundColor = .blue
        addSubview(sunPathChart)
        sunPathChart.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview().offset(50)
            maker.bottom.equalToSuperview().offset(-50)
        }
        
        let stackView = UIStackView()
        self.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(sunriseLabel)
        stackView.addArrangedSubview(sunsetLabel)
        
        backgroundColor = .red
    }
    
    func configure(data: SunriseStringValue) {
        sunriseLabel.text = data.sunriseValue
        sunsetLabel.text = data.sunsetValue
        
    }
}
*/
