//
//  PrecipitationWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit


class HumidityWidget: ViewWithRoundedCorner {
    struct HumidityStringValue {
        let humidityValue: String
        let description: String
    }
    
    let humidityValueLabel = UILabel()
    let descriptionLabel = UILabel()
    
    func prepare() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.height.equalToSuperview().inset(5)
            maker.bottom.equalToSuperview().inset(5)
            maker.left.equalToSuperview().inset(15)
            maker.right.equalToSuperview().inset(15)
        }
        stackView.addArrangedSubview(humidityValueLabel)
        humidityValueLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        humidityValueLabel.textColor = .white
        
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Helvetica", size: 16)
        descriptionLabel.textColor = .white
    }
    
    func configure(data: HumidityStringValue) {
        humidityValueLabel.text = data.humidityValue
        descriptionLabel.text = data.description
    }
}
