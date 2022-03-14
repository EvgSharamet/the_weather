//
//  StretchyTableHeaderView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 24.02.2022.
//

import Foundation
import UIKit


class StretchyTableHeaderView: UIView {
    struct HeaderStringValue {
        let cityName: String
        let temp: String
        let description: String
        let maxMinTemp: String
    }
    
    let containerView = UIView()
    let cityNameLabel = UILabel()
    let currentTempLabel = UILabel()
    let descriptionLabel = UILabel()
    let maxMinTempLabel = UILabel()
    
    func prepare(){
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        containerView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stack.backgroundColor = .clear
        stack.addArrangedSubview(cityNameLabel)
        cityNameLabel.textColor = .white
        cityNameLabel.textAlignment = .center
        cityNameLabel.font = cityNameLabel.font.withSize(40)
        
        stack.addArrangedSubview(currentTempLabel)
        currentTempLabel.font = currentTempLabel.font.withSize(75)
        currentTempLabel.textColor = .white
        currentTempLabel.textAlignment = .center
        
        stack.addArrangedSubview(descriptionLabel)
        descriptionLabel.font = descriptionLabel.font.withSize(20)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        
        stack.addArrangedSubview(maxMinTempLabel)
        maxMinTempLabel.font = maxMinTempLabel.font.withSize(20)
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
        
        maxMinTempLabel.alpha = (1 + offsetY * 0.1)
        descriptionLabel.alpha = (1 + offsetY * 0.05)
        currentTempLabel.alpha = (1 + offsetY * 0.009)
        cityNameLabel.alpha = (1 + offsetY * 0.005)
    }
}
