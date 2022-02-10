//
//  PressureWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit



class PressureWidget: ViewWithRoundedCorner {
    
    struct PressureStringValue {
        let pressureValue: String
    }
    
    let pressureValueLabel = UILabel()

    func prepare() {
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(pressureValueLabel)
    }

    func setData(data: PressureStringValue) {
        pressureValueLabel.text = data.pressureValue
    }
}
