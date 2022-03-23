//
//  PrecipitationWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit

class HumidityWidget: BaseWidgetView {
    //MARK: - types
    
    struct HumidityStringValue {
        let humidityValue: String
        let description: String
    }
    //MARK: - data
    
    private let humidityValueLabel = UILabel()
    private let descriptionLabel = UILabel()
    //MARK: - internal functions 

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
        stackView.addArrangedSubview(humidityValueLabel)
        humidityValueLabel.font = UIConst.regularBold35Font
        humidityValueLabel.textColor = .white
        
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIConst.regular16Font
        descriptionLabel.textColor = .white
    }
    
    func configure(data: HumidityStringValue) {
        humidityValueLabel.text = data.humidityValue
        descriptionLabel.text = data.description
    }
}
