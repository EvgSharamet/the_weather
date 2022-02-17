//
//  Sunrise.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 26.01.2022.
//

import Foundation
import SnapKit
import UIKit


class SunriseWidget: ViewWithRoundedCorner {
    
    struct SunriseStringValue {
        let sunrise: Date
        let sunset: Date
        let sunriseValue: String
        let sunsetValue: String
    }
    
    let sunriseLabel = UILabel()
    let sunsetLabel = UILabel()
    
    func prepare() {
        let stackView = UIStackView()
        self.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(sunriseLabel)
        stackView.addArrangedSubview(sunsetLabel)
    }
    
    func configure(data: SunriseStringValue) {
        sunriseLabel.text = data.sunriseValue
        sunsetLabel.text = data.sunsetValue
    }
}
