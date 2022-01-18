//
//   CurrentDayCell.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 17.01.2022.
//

import Foundation
import UIKit

class HourlyForecastCell: UITableViewCell {
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    func prepare() {
        contentView.backgroundColor = .green
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .yellow.withAlphaComponent(0.8)
        contentView.addSubview(scrollView)
        contentView.snp.makeConstraints { maker in
            maker.height.equalTo(300)
            maker.width.equalToSuperview()
        }
        print(contentView.frame)
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        let hourlyStackView = UIStackView()
        hourlyStackView.axis = .horizontal
        hourlyStackView.spacing = 10
        hourlyStackView.backgroundColor = .red
        scrollView.addSubview(hourlyStackView)
        hourlyStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        print(scrollView.frame)
        print(hourlyStackView.frame)
    }
}
