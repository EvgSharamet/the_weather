//
//  WindPrecipitationWidgetView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit



class WindPrecipitationWidgetSectionView: UITableViewCell {
    
    var stackView = UIStackView()
    var windWidget: WindWidget?
    var precipitationWidget: PrecipitationWidget?
    
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
           maker.width.equalToSuperview()
           maker.height.equalTo(150)
       }
       
       stackView.axis = .horizontal
       contentView.addSubview(stackView)
       stackView.snp.makeConstraints { maker in
           maker.edges.equalToSuperview()
       }
       stackView.distribution = .fillEqually
       stackView.spacing = 10
       
       let windWidget = WindWidget()
       self.windWidget = windWidget
       stackView.addArrangedSubview(windWidget)
       windWidget.prepare()
       
       let precipitationWidget = PrecipitationWidget()
       self.precipitationWidget = precipitationWidget
       stackView.addArrangedSubview(precipitationWidget)
       precipitationWidget.prepare()
    }
    
    func setData(data: WeatherDataService.OneDayResponse.Current, dataForPrecipitation: WeatherDataService.TenDaysResponse.Day) {
        windWidget?.setData(text: String(data.wind_speed))
        guard let rain = dataForPrecipitation.rain else {
            guard let snow = dataForPrecipitation.snow else {
                precipitationWidget?.setData(text: String("0"))
                return
            }
            precipitationWidget?.setData(text: String(snow) + " мм")
            return
        }
        precipitationWidget?.setData(text: String(rain) + " мм")
    }
}
