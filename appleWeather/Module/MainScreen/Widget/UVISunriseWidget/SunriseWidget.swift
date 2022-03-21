//
//  Sunrise.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 26.01.2022.
//

import Foundation
import SnapKit
import UIKit

class SunriseWidget: BaseCell {
    struct SunriseStringValue {
        let sunriseForGraph: Double
        let sunsetForGraph: Double
        let widgetName: String
        let sunset: String
        let sunrise: String
    }
    
    let sunriseLabel = UILabel()
    let sunsetLabel = UILabel()
    let indicatorView = UIView()
    let indicatorPointView = UIView()
    let beforeSunriseView =  UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    let afterSunsetView =  UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    
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
        stackView.addArrangedSubview(sunsetLabel)
        
        sunsetLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.2)
        }
        
        sunsetLabel.font = UIFont(name: "Helvetica", size: 35)
        sunsetLabel.textColor = .white
        
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

        beforeSunriseView.alpha = 0.5
        indicatorView.addSubview(beforeSunriseView)
        beforeSunriseView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.left.equalToSuperview()
        }
        
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
      
        indicatorPointView.layer.shadowOffset = .zero
        indicatorPointView.layer.shadowOpacity = 0.7
        indicatorPointView.layer.shadowRadius = 5
        indicatorPointView.layer.shadowColor = UIColor.white.cgColor
        indicatorPointView.layer.masksToBounds = false
        stackView.addArrangedSubview(sunriseLabel)
        sunriseLabel.font = UIFont(name: "Helvetica", size: 16)
        sunriseLabel.textColor = .white
        
        let gradient = CAGradientLayer()
         gradient.type = .axial
         gradient.colors = [
            UIColor.darkGray.withAlphaComponent(0.7).cgColor,
             UIColor.clear.cgColor,
            UIColor.darkGray.withAlphaComponent(0.7).cgColor
         ]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        indicatorView.layer.addSublayer(gradient)
        gradient.frame = CGRect(x: 0, y: 0, width: 170, height: 20)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        indicatorPointView.layer.shadowPath = UIBezierPath(ovalIn: indicatorPointView.bounds.insetBy(dx: -5, dy: -5)).cgPath
    }
    
    func configure(data: SunriseStringValue) {
        sunriseLabel.text = data.sunrise
        sunsetLabel.text = data.sunset
        
        let dateF = DateFormatter()
        dateF.dateFormat = "HH"
        if let offsetForSun = Double(dateF.string(from: Date())) {
            let pointLocation =  offsetForSun / 24 + 0.01
            indicatorPointView.snp.makeConstraints { maker in
                maker.height.equalTo(9)
                maker.width.equalTo(9)
                maker.centerY.equalTo(indicatorView)
                maker.right.equalTo(indicatorView).multipliedBy(pointLocation)
            }
            if offsetForSun <= data.sunriseForGraph || offsetForSun >= data.sunsetForGraph {
                indicatorPointView.backgroundColor = .darkGray
            }
        }
        
        beforeSunriseView.snp.makeConstraints { make in
            make.right.equalTo(indicatorView).multipliedBy((data.sunriseForGraph) / 24.0 + 0.01)
        }
        
        afterSunsetView.snp.makeConstraints { make in
            make.left.equalTo(indicatorView).multipliedBy((data.sunsetForGraph) / 24.0 + 0.01)
        }
    }
}
