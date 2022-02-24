//
//   CurrentDayCell.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import UIKit



class HourlyForecastSectionView: CellWithRoundedCorner {
    
    struct HourlyForecastStringValue {
        let list: [OneHourInfoView.OneHourStringValue]
    }
    
    var stackView: UIStackView?
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
        self.stackView = hourlyStackView
        self.hourlyStackView = hourlyStackView
        hourlyStackView.axis = .horizontal
        hourlyStackView.spacing = 10
        scrollView.addSubview(hourlyStackView)
        hourlyStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    func configure(data: HourlyForecastStringValue) {
        for hour in data.list {
            let oneHourInfoView = OneHourInfoView()
            oneHourInfoView.prepare()
            oneHourInfoView.configure(data: OneHourInfoView.OneHourStringValue(date: hour.date, iconString: hour.iconString, clouds: hour.clouds, showClouds: hour.showClouds, temp: hour.temp))
            self.stackView?.addArrangedSubview(oneHourInfoView)
            oneHourInfoView.snp.makeConstraints { maker in
                maker.height.equalTo(120)
                maker.width.equalTo(60)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hourlyStackView?.arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }
}
