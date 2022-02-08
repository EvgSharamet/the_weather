//
//  VisibilityPressureWidgetSectionView.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit



class VisibilityPressureWidgetSectionView: UITableViewCell {
    
    var stackView: UIStackView?
    var visibilityWidget: VisibilityWidget?
    var pressureWidget: PressureWidget?
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       prepare()
   }
   
   required init?(coder: NSCoder) {
       super.init(coder: coder)
       prepare()
   }
   
   func prepare() {
       
       self.selectionStyle = SelectionStyle.none
       self.backgroundColor = .clear
       contentView.snp.makeConstraints { maker in
           maker.height.equalTo(150)
           maker.width.equalToSuperview()
       }
       guard let stackView = stackView else {
           return
       }
       self.stackView = stackView
       stackView.axis = .horizontal
       
       contentView.addSubview(stackView)
       stackView.snp.makeConstraints { maker in
           maker.edges.equalToSuperview()
       }
       
       stackView.distribution = .fillEqually
       stackView.spacing = 10
       
       let visibilityWidget = VisibilityWidget()
       self.visibilityWidget = visibilityWidget
       visibilityWidget.prepare()
       
       let pressureWidget = PressureWidget()
       self.pressureWidget = pressureWidget
       pressureWidget.prepare()
       
       stackView.addArrangedSubview(visibilityWidget)
       stackView.addArrangedSubview(pressureWidget)
    }
    
    func setData(data: WeatherDataService.OneDayResponse.Current) {
        visibilityWidget?.setData(text: String(data.visibility))
        pressureWidget?.setData(text: String(data.pressure))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView?.arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }
}
