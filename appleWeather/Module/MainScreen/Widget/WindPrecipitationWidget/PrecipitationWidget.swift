//
//  PrecipitationWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit

class PrecipitationWidget: BaseWidgetView {
    //MARK: - types
    enum WeatherType {
        case rain, snow, rainWithSnow
    }
    
    struct PrecipitationStringValue {
        let weatherType: WeatherType?
        let textForHeader: String
        let currentValue: String
        let preciptiationText: String
        let futureValue: String
    }
    //MARK: - data
    
    private let valueNumberLabel = UILabel()
    private let valueTextLabel = UILabel()
    private let descriptionLabel = UILabel()
    //MARK: - internal functions
    
    func prepare() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(10)
            maker.left.equalToSuperview().inset(15)
            maker.right.equalToSuperview().inset(15)
        }
        
        stackView.addArrangedSubview(valueNumberLabel)
        valueNumberLabel.lineBreakMode = .byWordWrapping
        valueNumberLabel.numberOfLines = 0
        valueNumberLabel.font = UIConst.regular35Font
        valueNumberLabel.textColor = .white
        
        stackView.addArrangedSubview(valueTextLabel)
   
        valueTextLabel.lineBreakMode = .byWordWrapping
        valueTextLabel.numberOfLines = 0
        valueTextLabel.font = UIConst.regularBold20Font
        valueTextLabel.textColor = .white
        
        stackView.addArrangedSubview(descriptionLabel)
    
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIConst.regular16Font
        descriptionLabel.textColor = .white
    }
    
    func configure(data: PrecipitationStringValue) {
        valueNumberLabel.text = data.currentValue
        valueTextLabel.text =  data.preciptiationText
        descriptionLabel.text = data.futureValue
    }
}

