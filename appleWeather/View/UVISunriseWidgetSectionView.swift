//
//  CurrentForecastWidgetsView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 20.01.2022.
//

import Foundation
import UIKit
import SnapKit



class UVISunriseWidgetSectionView: UITableViewCell {
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       prepare()
   }
   
   required init?(coder: NSCoder) {
       super.init(coder: coder)
       prepare()
   }
   
   func prepare() {
       contentView.snp.makeConstraints { maker in
           maker.height.equalTo(120)
           maker.width.equalToSuperview()
           
       }
       let stackView = UIStackView()
       stackView.axis = .horizontal
       
       contentView.addSubview(stackView)
       stackView.snp.makeConstraints { maker in
           maker.edges.equalToSuperview()
       }
       stackView.distribution = .fillEqually
       stackView.spacing = 10
       
       let UVIView = UVIWidget()
       UVIView.prepare()
       let UVIView2 = UVIWidget()
       UVIView2.prepare()
       
       stackView.addArrangedSubview(UVIView)
       stackView.addArrangedSubview(UVIView2)
       
    }
}

