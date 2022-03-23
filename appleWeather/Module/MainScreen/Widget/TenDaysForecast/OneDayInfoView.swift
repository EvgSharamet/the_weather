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
    //MARK: - types
    struct OneDayStringValue {
        var icon: UIImage?
        let iconString: String
        let minString: String
        let maxString: String
        let globalMin: Int
        let globalMax: Int
        let localMin: Int
        let localMax: Int
        let pointCoord: Int
        let dayOfTheWeek: String
        let clouds: String
        let showClouds: Bool
        let showCurrentPointView: Bool
    }
    //MARK: - data
    private struct Const {
        static let distributionAxisWidth = 100
        static let distributionIndicatorCornerRadius = CGFloat(2)
        static let cloudsLabelHeight = CGFloat(14)
    }
    private let distributionIndicatorView = UIView()
    private let distributionAxisView = UIView()
    private let weatherIconImageView = UIImageView()
    private let dateLabel = UILabel()
    private let minTempLabel = UILabel()
    private let maxTempLabel = UILabel()
    private let currentPointView = UIImageView()
    private let cloudsLabel = UILabel()
    //MARK: - internal functions
    
    func prepare() {
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.distribution  = .fillEqually
        self.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        mainStackView.addArrangedSubview(dateLabel)
        dateLabel.font = UIConst.regularBold20Font
        dateLabel.textColor = .white
        
        mainStackView.addArrangedSubview(weatherIconImageView)
        weatherIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-10)
            make.bottom.equalToSuperview().inset(-10)
        }
        weatherIconImageView.contentMode = .scaleAspectFit
        
        weatherIconImageView.addSubview(cloudsLabel)
        cloudsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(Const.cloudsLabelHeight)
            make.centerX.equalToSuperview()
        }
        cloudsLabel.font = cloudsLabel.font.withSize(14)
        cloudsLabel.textAlignment = .center
        cloudsLabel.textColor = .cyan
        
        mainStackView.addArrangedSubview(minTempLabel)
        minTempLabel.textAlignment = .center
        minTempLabel.font = UIConst.regularBold20Font
        minTempLabel.textColor = .white.withAlphaComponent(0.7)
        let distributionView = UIView()
        mainStackView.addArrangedSubview(distributionView)
        distributionView.addSubview(distributionAxisView)
        distributionAxisView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.08)
            make.center.equalToSuperview()
            make.width.equalTo(Const.distributionAxisWidth)
        }
        
        distributionAxisView.layer.cornerRadius = Const.distributionIndicatorCornerRadius
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
        
        currentPointView.image = UIImage(named: "pointUVI")
        currentPointView.isHidden = true
        currentPointView.snp.updateConstraints { make in
            make.centerY.equalTo(distributionAxisView)
            make.height.equalTo(8)
            make.width.equalTo(8)
            make.left.equalTo(distributionAxisView)
        }
    
        mainStackView.addArrangedSubview(maxTempLabel)
        maxTempLabel.textAlignment = .center
        maxTempLabel.textColor = .white
        maxTempLabel.font = UIConst.regularBold20Font
    }

    func configure(data: OneDayStringValue) {
        weatherIconImageView.image = data.icon
        dateLabel.text = data.dayOfTheWeek
        minTempLabel.text = data.minString
        maxTempLabel.text = data.maxString
        if data.showClouds {
            cloudsLabel.text = data.clouds
        }
        
        let globalMin = Int(data.globalMin)
        let globalMax = Int(data.globalMax)
        
        let globalWidth = Double(globalMax - globalMin)
        let width = Double(data.localMax - data.localMin)
        
        if globalWidth != Double(0) {
            let indicatorRealWidth = Double(width / globalWidth)
            let leftOffset = Double( Int(data.localMin) - globalMin) / globalWidth * Double(Const.distributionAxisWidth)
            distributionIndicatorView.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(leftOffset)
                make.width.equalToSuperview().multipliedBy(Swift.max(Swift.min(indicatorRealWidth, 1.0), 0.1))
            }
        }
        
        if data.showCurrentPointView {
            currentPointView.isHidden = false
            let leftset = Double( Int(data.pointCoord) - globalMin) / globalWidth * Double(Const.distributionAxisWidth)
            currentPointView.snp.updateConstraints { make in
                make.left.equalTo(distributionAxisView).offset(leftset)
            }
        }
    }
}

