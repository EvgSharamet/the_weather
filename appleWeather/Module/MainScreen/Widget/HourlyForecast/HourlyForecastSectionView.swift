//
//   CurrentDayCell.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import UIKit

class HourlyForecastSectionView: BaseCell {
    struct HourlyForecastStringValue {
        let list: [OneHourInfoView.OneHourStringValue]
    }
    
    var hourlyStackView: UIStackView?
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepare()
    } 
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    func prepare() {
        backgroundColor = .clear

        let scrollView = UIScrollView()
        self.contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let hourlyStackView = UIStackView()
        self.hourlyStackView = hourlyStackView
        hourlyStackView.axis = .horizontal
        hourlyStackView.spacing = 10
        scrollView.addSubview(hourlyStackView)
        hourlyStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    func configure(data: HourlyForecastStringValue) {
        self.hourlyStackView?.arrangedSubviews.forEach{ $0.removeFromSuperview() }
        for hour in data.list {
            let oneHourInfoView = OneHourInfoView()
            oneHourInfoView.prepare()
            oneHourInfoView.configure(data: OneHourInfoView.OneHourStringValue(date: hour.date, iconString: hour.iconString, icon: hour.icon, clouds: hour.clouds,  showClouds: hour.showClouds, temp: hour.temp, sunsetSunriseView: hour.sunsetSunriseView))
            self.hourlyStackView?.addArrangedSubview(oneHourInfoView)
            if hour.sunsetSunriseView {
                oneHourInfoView.snp.makeConstraints { maker in
                    maker.height.equalTo(140)
                    maker.width.equalTo(140)
                }
            } else {
                oneHourInfoView.snp.makeConstraints { maker in
                    maker.height.equalTo(140)
                    maker.width.equalTo(60)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hourlyStackView?.arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }
}
