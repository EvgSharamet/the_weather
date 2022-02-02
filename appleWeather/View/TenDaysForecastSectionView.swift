//
//  TenDaysForecastSectionView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 20.01.2022.
//

import Foundation
import UIKit
import SnapKit



class TenDaysForecastSectionView: CellWithRoundedCorner {
    
    var tenDaysStackView: UIStackView?
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
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview()
        }
        
        let tenDaysStackView = UIStackView()
        self.tenDaysStackView = tenDaysStackView
        tenDaysStackView.axis = .vertical
        tenDaysStackView.spacing = 10
        self.addSubview(tenDaysStackView)
        tenDaysStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    func setData(data: WeatherDataService.TenDaysResponse) {
        for i in data.list {
            let oneDayInfoView = OneDayInfoView()
            tenDaysStackView?.addArrangedSubview(oneDayInfoView)
            oneDayInfoView.prepare(weatherData: i)
            oneDayInfoView.snp.makeConstraints { maker in
                maker.height.equalTo(30)
                maker.width.equalToSuperview()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tenDaysStackView?.arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }
}
