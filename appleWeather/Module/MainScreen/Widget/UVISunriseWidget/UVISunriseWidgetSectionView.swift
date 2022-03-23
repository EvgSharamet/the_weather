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
    // MARK: - data
    
    private let stackView = UIStackView()
    private var uviWidget: UVIWidget?
    private var sunriseWidget: SunriseWidget?
    
    // MARK: - internal functions
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       prepare()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder) has not been implemented")
    }
   
    func configure(dataForUVIVidget: UVIWidget.UVIndexStringValue, dataForSunriseVidget: SunriseWidget.SunriseStringValue) {
        uviWidget?.configure(data: dataForUVIVidget)
        sunriseWidget?.configure(data: dataForSunriseVidget)
    }
    // MARK: - private functions
    
   private func prepare() {
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
}

