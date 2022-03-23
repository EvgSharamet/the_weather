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
    struct TenDaysStringValue {
        let list: [OneDayInfoView.OneDayStringValue]
    }
    
    var tenDaysStackView: UIStackView?
    //MARK: - internal functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    func configure(data: TenDaysStringValue) {
        tenDaysStackView?.arrangedSubviews.forEach{ $0.removeFromSuperview() }
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
    //MARK: - private functions
    
    private func prepare() {
        self.backgroundColor = .clear
        let baseView = BaseWidgetView()
        baseView.setRoundedCorners([.bottomLeft, .bottomRight])
        self.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let tenDaysStackView = UIStackView()
        self.tenDaysStackView = tenDaysStackView
        tenDaysStackView.axis = .vertical
        tenDaysStackView.distribution = .fillEqually
        baseView.addSubview(tenDaysStackView)
        tenDaysStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(10)
        }
    }
}
