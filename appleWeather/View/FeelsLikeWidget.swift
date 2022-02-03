//
//  FeelsLikeWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit


class FeelsLikeWidget: ViewWithRoundedCorner {
    let valueNumberLabel = UILabel()
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
        stackView.addArrangedSubview(valueNumberLabel)
        valueNumberLabel.font = valueNumberLabel.font.withSize(30)
        valueNumberLabel.textColor = .white
        
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = descriptionLabel.font.withSize(16)
        descriptionLabel.textColor = .white
    }
    
    func setData(text: String) {
        valueNumberLabel.text = text
        descriptionLabel.text = "По ощущениям холоднее из-за погоды"
    }
}