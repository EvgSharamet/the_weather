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
    var containerView: UIView = UIView()
     
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
        
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.snp.makeConstraints { maker in
            maker.height.equalTo(120)
            maker.width.equalToSuperview()
        }

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

    func setData(data: WeatherDataService.OneDayResponse) {
        
        for i in data.hourly {
            let oneHourInfoView = OneHourInfoView()
            oneHourInfoView.prepare(weatherData: i)
            self.stackView?.addArrangedSubview(oneHourInfoView)
            oneHourInfoView.snp.makeConstraints { maker in
                maker.top.equalTo(self.contentView.snp_topMargin)
                maker.bottom.equalTo(self.contentView.snp_bottomMargin)
                maker.width.equalTo(60)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView?.arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }
}
