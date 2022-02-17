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
    
    struct TenDaysStringValue {
        let list: [OneDayInfoView.OneDayStringValue]
        let todayPoint: Double
    }
    
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
        let tenDaysStackView = UIStackView()
        self.tenDaysStackView = tenDaysStackView
        tenDaysStackView.axis = .vertical
        tenDaysStackView.distribution = .fillEqually
        self.addSubview(tenDaysStackView)
        tenDaysStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(10)
        }
    }
    
    func configure(data: TenDaysStringValue) {
        for dayData in data.list {
            let oneDayInfoView = OneDayInfoView()
            tenDaysStackView?.addArrangedSubview(oneDayInfoView)
            oneDayInfoView.prepare()
            oneDayInfoView.configure(data: dayData)
            oneDayInfoView.snp.makeConstraints { maker in
                maker.width.equalToSuperview()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tenDaysStackView?.arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }
}
