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
        let sunrise: Double
        let sunset: Double
        let sunriseValue: String
        let sunsetValue: String
    }
    
    let sunriseLabel = UILabel()
    let sunsetLabel = UILabel()
    let sunPathChart = SunPathView()
    
    func prepare() {
        sunPathChart.backgroundColor = .blue
        addSubview(sunPathChart)
        sunPathChart.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview().offset(50)
            maker.bottom.equalToSuperview().offset(-50)
        }
        
        let stackView = UIStackView()
        self.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(sunriseLabel)
        stackView.addArrangedSubview(sunsetLabel)
        
        backgroundColor = .red
    }
    
    func configure(data: SunriseStringValue) {
        sunriseLabel.text = data.sunriseValue
        sunsetLabel.text = data.sunsetValue
        
    }
}
