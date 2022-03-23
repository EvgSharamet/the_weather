//
//  FeelsLikeHumidityWidgetSectionView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit

class FeelsLikeHumidityWidgetSectionView: UITableViewCell {
    //MARK: - data
    
    private var stackView = UIStackView()
    private var feelsLikeWidget: FeelsLikeWidget?
    private var humidityWidget: HumidityWidget?
    //MARK: - internal functions

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       prepare()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }

    func configure(dataForFeelsLikeWidget:  FeelsLikeWidget.FeelsLikeStringValue, dataForHumidityWidget: HumidityWidget.HumidityStringValue) {
        feelsLikeWidget?.configure(data: dataForFeelsLikeWidget)
        humidityWidget?.configure(data: dataForHumidityWidget)
    }
    //MARK: - private functions

    private func prepare() {
       self.backgroundColor = .clear
       self.selectionStyle = SelectionStyle.none

       stackView.arrangedSubviews.forEach{ $0.removeFromSuperview() }
       stackView.axis = .horizontal
       
       contentView.addSubview(stackView)
       stackView.snp.makeConstraints { maker in
           maker.edges.equalToSuperview()
       }
       stackView.distribution = .fillEqually
       stackView.spacing = 10
       
       let feelsLikeWidget = FeelsLikeWidget()
       self.feelsLikeWidget = feelsLikeWidget
       feelsLikeWidget.setRoundedCorners([.bottomLeft, .bottomRight])
       feelsLikeWidget.prepare()
       
       let humidityWidget = HumidityWidget()
       self.humidityWidget = humidityWidget
       humidityWidget.setRoundedCorners([.bottomLeft, .bottomRight])
       humidityWidget.prepare()
       
       stackView.addArrangedSubview(feelsLikeWidget)
       stackView.addArrangedSubview(humidityWidget)
    }
}

