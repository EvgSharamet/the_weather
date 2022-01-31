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
    let textLabel = UILabel()
    
    func prepare() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        self.addSubview(stackView)
        stackView.backgroundColor = .purple.withAlphaComponent(0.2)
        stackView.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.left.equalToSuperview().inset(10)
            maker.right.equalToSuperview().inset(10)
        }
        stackView.addArrangedSubview(textLabel)
        
        let indicatorView = UIImageView()
        indicatorView.backgroundColor = .blue.withAlphaComponent(0.3)
        stackView.addArrangedSubview(indicatorView)
        indicatorView.snp.makeConstraints { maker in
            maker.height.equalTo(7)
        }
        indicatorView.image = UIImage(named:"gradient")
        let descriptionLabel = UILabel()
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    func setData(text: String) {
        textLabel.text = text
    }
}
