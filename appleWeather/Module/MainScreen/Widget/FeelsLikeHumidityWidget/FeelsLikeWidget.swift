//
//  FeelsLikeWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit

class FeelsLikeWidget: BaseWidgetView {
    struct FeelsLikeStringValue {
        let feelsLikeValue: String
        let description: String?
    }
    
    let feelsLikeValueLabel = UILabel()
    let descriptionLabel = UILabel()
    
    func prepare() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.height.equalToSuperview().inset(10)
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().inset(15)
            maker.right.equalToSuperview().inset(15)
        }
        stackView.addArrangedSubview( feelsLikeValueLabel)
        feelsLikeValueLabel.font =  UIFont(name: "HelveticaNeue-Medium", size: 35)
        feelsLikeValueLabel.textColor = .white
        
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Helvetica", size: 16)
        descriptionLabel.textColor = .white
    }
    
    func configure(data: FeelsLikeStringValue) {
        feelsLikeValueLabel.text = data.feelsLikeValue
        descriptionLabel.text = data.description
    }
}
