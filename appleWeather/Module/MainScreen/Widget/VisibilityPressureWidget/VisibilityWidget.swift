//
//  VisibilityWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit

class VisibilityWidget: BaseWidgetView {
    //MARK: - types
    
    struct VisibilityStringValue {
        let visibilityValue: String
        let description: String?
    }
    //MARK: - data
    
    private let visibilityValueLabel = UILabel()
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
        stackView.addArrangedSubview(visibilityValueLabel)
        visibilityValueLabel.font = UIConst.regularBold35Font
        visibilityValueLabel.textColor = .white
        
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIConst.regular16Font
        descriptionLabel.textColor = .white
    }
    
    func configure(data: VisibilityStringValue) {
        visibilityValueLabel.text = data.visibilityValue
        descriptionLabel.text = data.description
    }
}
