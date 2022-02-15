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
        let number: Float
        let numberValue: String
        let textValue: String
        let description: String
    }
    
    let valueNumberLabel = UILabel()
    let valueTextLabel = UILabel()
    let descriptionLabel = UILabel()
    let indicatorView = UIImageView()
    let indicatorPointView = UIImageView()
    
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
    
        stackView.addArrangedSubview(indicatorView)
        indicatorView.snp.makeConstraints { maker in
            maker.height.equalToSuperview().multipliedBy(0.05)
           
        }
        indicatorView.layer.cornerRadius = 4
        indicatorView.contentMode = .scaleAspectFit
        indicatorView.layer.masksToBounds = true
        indicatorView.image = UIImage(named:"gradientUVI")
   
        indicatorPointView.image = UIImage(named:"pointUVI")
        indicatorPointView.contentMode = .scaleAspectFill
        self.addSubview(indicatorPointView)
        indicatorPointView.snp.makeConstraints { maker in
            maker.height.equalTo(indicatorView)
            maker.width.equalTo(8)
            maker.centerY.equalTo(indicatorView)
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
        let pointLocation = data.number / 12 + 0.01
        indicatorPointView.snp.makeConstraints { make in
            make.right.equalTo(indicatorView).multipliedBy(pointLocation)
        }
    }
}
