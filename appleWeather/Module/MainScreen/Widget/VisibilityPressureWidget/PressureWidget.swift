//
//  PressureWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit

class PressureWidget: BaseWidgetView {
    struct PressureStringValue {
        let pressureValue: String
        let degreesForGraph: Int
        let aboveNorm: Bool
        let willRise: Bool
        let description: String
    }
    
    let pressureValueLabel = UILabel()
    let graphImageView = UIImageView()
    let valueSegmentImageView = UIImageView()
    let arrowImageView = UIImageView()
    let descriptionLabel = UILabel()
    
    func prepare() {
        self.addSubview(graphImageView)
        graphImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        graphImageView.contentMode = .scaleAspectFit
        graphImageView.image = UIImage(named: "graphPressure")
    
        self.addSubview(valueSegmentImageView)
        valueSegmentImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        valueSegmentImageView.contentMode = .scaleAspectFit
        valueSegmentImageView.image = UIImage(named: "valueSegmentPressure")
        
        let centerStackView = UIStackView()
        self.addSubview(centerStackView)
        centerStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(65)
            make.width.equalTo(80)
        }
        centerStackView.axis = .vertical
        centerStackView.distribution = .equalSpacing
        
        centerStackView.addArrangedSubview(arrowImageView)
        arrowImageView.image = UIImage(named: "arrowPressure")
        arrowImageView.contentMode = .scaleAspectFit
        
        
        centerStackView.addArrangedSubview(pressureValueLabel)
        pressureValueLabel.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.33)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
        }
        pressureValueLabel.textAlignment = .center
        pressureValueLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        pressureValueLabel.textColor = .white
        
        
        centerStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.font = UIFont(name: "Helvetica", size: 16)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        
        let arrowDown = UIImageView()
        self.addSubview(arrowDown)
        arrowDown.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview().offset(-20)
        }
        arrowDown.contentMode = .scaleAspectFit
        arrowDown.image = UIImage(named: "arrowPressure")
        arrowDown.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let arrowUp = UIImageView()
        self.addSubview(arrowUp)
        arrowUp.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview().offset(20)
        }
        arrowUp.contentMode = .scaleAspectFit
        arrowUp.image = UIImage(named: "arrowPressure")
    }
    
    func configure(data: PressureStringValue) {
        pressureValueLabel.text = data.pressureValue
        valueSegmentImageView.transform = .identity
        if data.willRise {
            valueSegmentImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
            valueSegmentImageView.transform = valueSegmentImageView.transform.rotated(by: CGFloat(-data.degreesForGraph) * .pi / 180 )
        } else {
            valueSegmentImageView.transform = valueSegmentImageView.transform.rotated(by: CGFloat(data.degreesForGraph) * .pi / 180 )
        }
        if data.aboveNorm  == false {
            arrowImageView.transform = CGAffineTransform(scaleX: 1, y: -1)
        }
        descriptionLabel.text = data.description
    }
}
