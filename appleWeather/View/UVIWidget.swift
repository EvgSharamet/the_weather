//
//  UVIWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 24.01.2022.
//

import Foundation
import UIKit
import SnapKit



class UVIWidget: ViewWithRoundedCorner {
    
    struct UVIndexStringValue {
        let numberValue: String
        let textValue: String
        let description: String
    }
    
    let valueNumberLabel = UILabel()
    let valueTextLabel = UILabel()
    let descriptionLabel = UILabel()
    
    func prepare() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.height.equalToSuperview().inset(10)
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().inset(15)
            maker.right.equalToSuperview().inset(15)
        }
        
        stackView.addArrangedSubview(valueNumberLabel)
        valueNumberLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.2)
        }
        
        valueNumberLabel.font = valueNumberLabel.font.withSize(30)
        valueNumberLabel.textColor = .white
        
        stackView.addArrangedSubview(valueTextLabel)
        valueTextLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.2)
        }
        valueTextLabel.font = valueTextLabel.font.withSize(25)
        valueTextLabel.textColor = .white
    
        let indicatorView = UIImageView()
        stackView.addArrangedSubview(indicatorView)
        indicatorView.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.05)
        }
        indicatorView.image = UIImage(named:"gradient")
        
        let indicatorPointView = UIImageView()
        indicatorPointView.image = UIImage(named:"point")
        indicatorPointView.contentMode = .scaleAspectFill
        indicatorView.addSubview(indicatorPointView)
        indicatorPointView.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            maker.width.equalTo(8)
            maker.centerY.equalToSuperview()
        }
   
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = descriptionLabel.font.withSize(16)
        descriptionLabel.textColor = .white
        descriptionLabel.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.45)
        }
    }
    
    func setData(data: UVIndexStringValue) {
        valueNumberLabel.text = data.numberValue
        valueTextLabel.text = data.textValue
        descriptionLabel.text = data.description
    }
}
