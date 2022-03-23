//
//  StretchyTableHeaderView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 24.02.2022.
//

import Foundation
import UIKit

class TableHeaderView: UIView {
    //MARK: - types
    
    struct HeaderStringValue {
        let cityName: String
        let temp: String
        let description: String
        let maxMinTemp: String
    }
    //MARK: - data
    
    private struct Const {
        static let maxMinTempOffsetMult = 0.1
        static let descriptionLabelOffsetMult = 0.05
        static let currentTempLabelOffsetMult = 0.009
        static let cityNameLabelOffsetMult = 0.005
    }
    
    private let containerView = UIView()
    private let cityNameLabel = UILabel()
    private let currentTempLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let maxMinTempLabel = UILabel()
    //MARK: - internal functions 
    
    func prepare(){
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        containerView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stack.backgroundColor = .clear
        stack.addArrangedSubview(cityNameLabel)
        cityNameLabel.textColor = .white
        cityNameLabel.textAlignment = .center
        cityNameLabel.font = UIConst.headerName40Font

        stack.addArrangedSubview(currentTempLabel)
        currentTempLabel.font = UIConst.headerTemp90Font
        currentTempLabel.textColor = .white
        currentTempLabel.textAlignment = .center
        
        stack.addArrangedSubview(descriptionLabel)
        descriptionLabel.font = UIConst.regularBold20Font
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        
        stack.addArrangedSubview(maxMinTempLabel)
        maxMinTempLabel.font = UIConst.regularBold20Font
        maxMinTempLabel.textColor = .white
        maxMinTempLabel.textAlignment = .center
    }
    
    func configure(data: HeaderStringValue) {
        cityNameLabel.text = data.cityName
        currentTempLabel.text = data.temp
        descriptionLabel.text = data.description
        maxMinTempLabel.text = data.maxMinTemp
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        self.clipsToBounds = offsetY <= 0

        containerView.snp.updateConstraints { make in
            make.bottom.equalTo(offsetY >= 0 ? 0 : -offsetY / 2)
            make.top.equalTo(offsetY <= 0 ? -offsetY : 0)
        }
        
        maxMinTempLabel.alpha = (1 + offsetY * Const.maxMinTempOffsetMult)
        descriptionLabel.alpha = (1 + offsetY * Const.descriptionLabelOffsetMult)
        currentTempLabel.alpha = (1 + offsetY * Const.currentTempLabelOffsetMult)
        cityNameLabel.alpha = (1 + offsetY * Const.cityNameLabelOffsetMult)
    }
}
