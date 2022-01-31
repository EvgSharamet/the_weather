//
//   CurrentDayCell.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import UIKit


class HourlyForecastSectionView: CellWithRoundedCorner {
    
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
        
        contentView.snp.makeConstraints { maker in
            maker.height.equalTo(120)
            maker.width.equalToSuperview()
        }

        let scrollView = UIScrollView()
        
        contentView.addSubview(scrollView)
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
    
    func setData(data: WeatherDataService.OneDayResponse) {
        
        for i in data.hourly {
            let oneHourInfoView = OneHourInfoView()
            oneHourInfoView.prepare(weatherData: i)
            oneHourInfoView.snp.makeConstraints { maker in
                maker.height.equalTo(120)
                maker.width.equalTo(60)
            }
            hourlyStackView?.addArrangedSubview(oneHourInfoView)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView?.arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }
}
