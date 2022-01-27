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
    let textLabel = UILabel()

    func prepare() {
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(textLabel)
    }

    func setData(text: String) {
        textLabel.text = text
    }
}
