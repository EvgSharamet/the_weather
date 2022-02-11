//
//  PrecipitationWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit



class PrecipitationWidget: ViewWithRoundedCorner {
   
    enum WeatherType {
        case rain, snow, rainWithSnow
    }
    
    struct PrecipitationStringValue {
        let weatherType: WeatherType?
        let textForHeader: String
        let currentValue: String
        let preciptiationText = "За последние сутки"
        let futureValue: String
    }
    
    let valueNumberLabel = UILabel()
    let valueTextLabel = UILabel()
    let descriptionLabel = UILabel()
    
    func prepare() {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.height.equalToSuperview().inset(10)
            maker.left.equalToSuperview().inset(15)
            maker.right.equalToSuperview().inset(15)
            maker.centerY.equalToSuperview()
        }
        
        stackView.addArrangedSubview(valueNumberLabel)

        valueNumberLabel.lineBreakMode = .byWordWrapping
        valueNumberLabel.numberOfLines = 0
        valueNumberLabel.font = valueNumberLabel.font.withSize(30)
        valueNumberLabel.textColor = .white
        
        
        stackView.addArrangedSubview(valueTextLabel)
   
        valueTextLabel.lineBreakMode = .byWordWrapping
        valueTextLabel.numberOfLines = 0
        valueTextLabel.font = valueTextLabel.font.withSize(20)
        valueTextLabel.textColor = .white
        
        stackView.addArrangedSubview(descriptionLabel)
    
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = descriptionLabel.font.withSize(15)
        descriptionLabel.textColor = .white
    }
    
    func setData(data: PrecipitationStringValue) {
        valueNumberLabel.text = data.currentValue
        valueTextLabel.text =  data.preciptiationText
        descriptionLabel.text = data.futureValue
    }
}

