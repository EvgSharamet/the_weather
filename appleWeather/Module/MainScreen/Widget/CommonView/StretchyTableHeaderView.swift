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
        cityNameLabel.font = UIFont(name: "Helvetica", size: 40)
        cityNameLabel.shadowColor = .darkGray
        cityNameLabel.layer.shadowOpacity = 0.1
        cityNameLabel.shadowOffset = CGSize(width: 1, height: 0)
        
        stack.addArrangedSubview(currentTempLabel)
        currentTempLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 90)
        currentTempLabel.textColor = .white
        currentTempLabel.textAlignment = .center
        currentTempLabel.shadowColor = .darkGray
        currentTempLabel.layer.shadowOpacity = 0.1
        currentTempLabel.shadowOffset = CGSize(width: 1, height: 0)
        
        stack.addArrangedSubview(descriptionLabel)
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.shadowColor = .darkGray
        descriptionLabel.layer.shadowOpacity = 0.1
        descriptionLabel.shadowOffset = CGSize(width: 1, height: 0)
        
        stack.addArrangedSubview(maxMinTempLabel)
        maxMinTempLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        maxMinTempLabel.textColor = .white
        maxMinTempLabel.textAlignment = .center
        maxMinTempLabel.shadowColor = .darkGray
        maxMinTempLabel.layer.shadowOpacity = 0.1
        maxMinTempLabel.shadowOffset = CGSize(width: 1, height: 0)
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
