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
    let valueNumberLabel = UILabel()
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
        valueNumberLabel.text = text + "%"
        descriptionLabel.text = "точка росы сейчас -- - 1"
    }
}
