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
    
    var stackView = UIStackView()
    var feelsLikeWidget: FeelsLikeWidget?
    var humidityWidget: HumidityWidget?
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       prepare()
   }
   
   required init?(coder: NSCoder) {
       super.init(coder: coder)
       prepare()
   }
   
   func prepare() {
       self.backgroundColor = .clear
       self.selectionStyle = SelectionStyle.none
       
       contentView.snp.makeConstraints { maker in
           maker.height.equalTo(150)
           maker.width.equalToSuperview()
       }
    
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
       feelsLikeWidget.prepare()
       
       let humidityWidget = HumidityWidget()
       self.humidityWidget = humidityWidget
       humidityWidget.prepare()
       
       stackView.addArrangedSubview(feelsLikeWidget)
       stackView.addArrangedSubview(humidityWidget)
    }
    
    func setData(data: WeatherDataService.OneDayResponse.Current) {
        feelsLikeWidget?.setData(text: String(data.feels_like))
        humidityWidget?.setData(text: String(data.humidity))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }
}

