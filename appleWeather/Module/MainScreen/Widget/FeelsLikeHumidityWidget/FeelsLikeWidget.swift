//
//  FeelsLikeWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit

class FeelsLikeWidget: BaseWidgetView {
    //MARK: - types
    
    struct FeelsLikeStringValue {
        let feelsLikeValue: String
        let description: String?
    }
    //MARK: - data
    
    private let feelsLikeValueLabel = UILabel()
    private let descriptionLabel = UILabel()
    //MARK: - internal functions 
    
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
        stackView.addArrangedSubview( feelsLikeValueLabel)
        feelsLikeValueLabel.font = UIConst.regularBold35Font
        feelsLikeValueLabel.textColor = .white
        
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIConst.regular16Font
        descriptionLabel.textColor = .white
    }
    
    func configure(data: FeelsLikeStringValue) {
        feelsLikeValueLabel.text = data.feelsLikeValue
        descriptionLabel.text = data.description
    }
}
