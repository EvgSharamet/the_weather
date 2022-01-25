//
//  TenDaysForecastSectionView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 20.01.2022.
//

import Foundation
import UIKit
import SnapKit



class TenDaysForecastSectionView: UITableViewCell {
    
    var tenDaysStackView: UIStackView?
     
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
            maker.height.equalTo(400)
            maker.width.equalToSuperview()
        }
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        contentView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        let tenDaysStackView = UIStackView()
        self.tenDaysStackView = tenDaysStackView
        tenDaysStackView.axis = .vertical
        tenDaysStackView.spacing = 10
        contentView.addSubview(tenDaysStackView)
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
}
