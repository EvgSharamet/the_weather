//
//  UVIWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 24.01.2022.
//

import Foundation
import UIKit
import SnapKit

class UVIWidget: BaseWidgetView {
    //MARK: - types
    struct UVIndexStringValue {
        let number: Float
        let numberValue: String
        let textValue: String
        let description: String
    }
    
    private struct Const {
        static let indicatorViewCornerRadius = CGFloat(25)
        static let indicatorHeight = CGFloat(35)
        static let indicatorPointDeameter = CGFloat(8)
        static let numberOfUVISegments = 12
    }
    //MARK: - data
    
    private let valueNumberLabel = UILabel()
    private let valueTextLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let indicatorView = UIView()
    private let indicatorPointView = UIImageView()
    private let indicator = UIImageView()
    //MARK: - internal functions
    
    func prepare() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(10)
            maker.bottom.equalToSuperview().inset(10)
            maker.left.equalToSuperview().inset(15)
            maker.right.equalToSuperview().inset(15)
        }
        
        stackView.addArrangedSubview(valueNumberLabel)
        
        valueNumberLabel.font = UIConst.regularBold35Font
        valueNumberLabel.textColor = .white
        
        stackView.addArrangedSubview(valueTextLabel)
        valueTextLabel.font = UIConst.regularBold20Font
        valueTextLabel.textColor = .white
    
        stackView.addArrangedSubview(indicatorView)
        indicatorView.layer.cornerRadius = CGFloat(Const.indicatorViewCornerRadius)
        indicatorView.layer.masksToBounds = true
        indicator.contentMode = .scaleAspectFit
        indicator.image = UIImage(named: "gradientUVI")
        indicatorView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.height.equalTo(Const.indicatorHeight)
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        indicatorPointView.image = UIImage(named:"pointUVI")
        indicatorPointView.contentMode = .scaleAspectFill
        self.addSubview(indicatorPointView)
        indicatorPointView.snp.makeConstraints { maker in
            maker.height.width.equalTo(Const.indicatorPointDeameter)
            maker.centerY.equalTo(indicator)
        }
   
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Helvetica", size: 16)
        descriptionLabel.textColor = .white
    }
    
    func configure(data: UVIndexStringValue) {
        valueNumberLabel.text = data.numberValue
        valueTextLabel.text = data.textValue
        descriptionLabel.text = data.description
        let pointLocation = data.number / Float(Const.numberOfUVISegments) + 0.1
        indicatorPointView.snp.makeConstraints { make in
            make.right.equalTo(indicator).multipliedBy(pointLocation)
        }
    }
}
