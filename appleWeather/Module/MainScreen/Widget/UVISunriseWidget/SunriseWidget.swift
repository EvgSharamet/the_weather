//
//  Sunrise.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 26.01.2022.
//

import Foundation
import SnapKit
import UIKit

class SunriseWidget: BaseWidgetView {
    //MARK: - types
    struct SunriseStringValue {
        let sunriseForGraph: Double
        let sunsetForGraph: Double
        let widgetName: String
        let sunset: String
        let sunrise: String
    }
    //MARK: - data
    
    private struct Const {
        static let inducatorCornerRadius = CGFloat(4)
        static let sunriseGradientAlpha = 0.5
        static let indicatorHeight = CGFloat(7)
        static let indicatorPointRadius = 4.5
        static let sunriseSegments = 24
    }
    
    private let sunriseLabel = UILabel()
    private let sunsetLabel = UILabel()
    private let indicator = UIView()
    private let indicatorView = UIView()
    private let indicatorPointView = UIView()
    private let beforeSunriseView =  UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    private let afterSunsetView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
  
    //MARK: - internal functions 
    func prepare() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(10)
            maker.bottom.equalToSuperview().inset(10)
            maker.left.equalToSuperview().inset(15)
            maker.right.equalToSuperview().inset(15)
        }
        stackView.addArrangedSubview(sunsetLabel)
        
        sunsetLabel.font = UIFont(name: "Helvetica", size: 35)
        sunsetLabel.textColor = .white
        
        stackView.addArrangedSubview(indicatorView)
        indicatorView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.height.equalTo(Const.indicatorHeight)
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        indicator.layer.cornerRadius = Const.inducatorCornerRadius
        indicator.contentMode = .scaleAspectFit
        indicator.layer.masksToBounds = true
    
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        indicator.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        beforeSunriseView.alpha = Const.sunriseGradientAlpha
        indicator.addSubview(beforeSunriseView)
        beforeSunriseView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.left.equalToSuperview()
        }
        
        afterSunsetView.alpha = Const.sunriseGradientAlpha
        indicator.addSubview(afterSunsetView)
        afterSunsetView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.right.equalToSuperview()
        }
    
        indicatorPointView.backgroundColor = .white
        indicatorPointView.layer.cornerRadius = Const.indicatorPointRadius
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
        indicator.layer.addSublayer(gradient)
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
            let pointLocation =  offsetForSun / Double(Const.sunriseSegments) + 0.01
            indicatorPointView.snp.makeConstraints { maker in
                maker.height.equalTo(9)
                maker.width.equalTo(9)
                maker.centerY.equalTo(indicator)
                maker.right.equalTo(indicator).multipliedBy(pointLocation)
            }
            if offsetForSun <= data.sunriseForGraph || offsetForSun >= data.sunsetForGraph {
                indicatorPointView.backgroundColor = .darkGray
            }
        }
        
        beforeSunriseView.snp.makeConstraints { make in
            make.right.equalTo(indicator).multipliedBy((data.sunriseForGraph) / Double(Const.sunriseSegments) + 0.01)
        }
        
        afterSunsetView.snp.makeConstraints { make in
            make.left.equalTo(indicator).multipliedBy((data.sunsetForGraph) / Double(Const.sunriseSegments) + 0.01)
        }
    }
}
