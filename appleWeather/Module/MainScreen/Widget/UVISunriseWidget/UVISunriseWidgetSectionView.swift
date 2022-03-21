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
    var stackView = UIStackView()
    var uviWidget: UVIWidget?
    var sunriseWidget: SunriseWidget?
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       prepare()
   }
   
   required init?(coder: NSCoder) {
       super.init(coder: coder)
       prepare()
   }
   
   func prepare() {
       self.backgroundColor = .clear
       self.selectionStyle = SelectionStyle.none

       stackView.arrangedSubviews.forEach{ $0.removeFromSuperview() }
       stackView.axis = .horizontal
       contentView.addSubview(stackView)
       stackView.snp.makeConstraints { maker in
           maker.edges.equalToSuperview()
       }
       stackView.distribution = .fillEqually
       stackView.spacing = 10
       
       let uviWidget = UVIWidget()
       self.uviWidget = uviWidget
       uviWidget.setRoundedCorners([.bottomLeft, .bottomRight])
       uviWidget.prepare()
       
       let sunriseWidget = SunriseWidget()
       self.sunriseWidget = sunriseWidget
       sunriseWidget.setRoundedCorners([.bottomLeft, .bottomRight])
       sunriseWidget.prepare()
        
       stackView.addArrangedSubview(uviWidget)
       stackView.addArrangedSubview(sunriseWidget)
    }
    
    func configure(dataForUVIVidget: UVIWidget.UVIndexStringValue, dataForSunriseVidget: SunriseWidget.SunriseStringValue) {
        uviWidget?.configure(data: dataForUVIVidget)
        sunriseWidget?.configure(data: dataForSunriseVidget)
    }
}

