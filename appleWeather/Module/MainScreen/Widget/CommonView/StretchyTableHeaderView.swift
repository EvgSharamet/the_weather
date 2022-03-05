//
//  StretchyTableHeaderView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 24.02.2022.
//

import Foundation
import UIKit


class StretchyTableHeaderView: UIView {
    struct HeaderStringValue {
        let cityName: String
        let temp: String
        let description: String
        let maxMinTemp: String
    }
    
    let cityNameLabel = UILabel()
    let currentTempLabel = UILabel()
    let descriptionLabel = UILabel()
    let maxMinTempLabel = UILabel()
    
    func prepare(){
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        self.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stack.backgroundColor = .clear
        stack.addArrangedSubview(cityNameLabel)
        cityNameLabel.font = cityNameLabel.font.withSize(40)
        cityNameLabel.textColor = .white
        cityNameLabel.textAlignment = .center
        
        stack.addArrangedSubview(currentTempLabel)
        currentTempLabel.font = currentTempLabel.font.withSize(75)
        currentTempLabel.textColor = .white
        currentTempLabel.textAlignment = .center
        
        stack.addArrangedSubview(descriptionLabel)
        descriptionLabel.font = descriptionLabel.font.withSize(20)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        
        stack.addArrangedSubview(maxMinTempLabel)
        maxMinTempLabel.font = maxMinTempLabel.font.withSize(20)
        maxMinTempLabel.textColor = .white
        maxMinTempLabel.textAlignment = .center
    }
    
    func configure(data: HeaderStringValue) {
        cityNameLabel.text = data.cityName
        currentTempLabel.text = data.temp
        descriptionLabel.text = data.description
        maxMinTempLabel.text = data.maxMinTemp
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }
}
