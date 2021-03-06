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
    //MARK: - data
    private var stackView = UIStackView()
    private var visibilityWidget: VisibilityWidget?
    private var pressureWidget: PressureWidget?
    
    //MARK: - internal functions
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       prepare()
   }
   
    required init?(coder: NSCoder) {
       fatalError("init(coder) has not been implemented")
    }
    
    func configure(dataForVisibilityWidget: VisibilityWidget.VisibilityStringValue, dataForPressureWidget: PressureWidget.PressureStringValue) {
        visibilityWidget?.configure(data: dataForVisibilityWidget)
        pressureWidget?.configure(data: dataForPressureWidget)
    }
    //MARK: - private functions
    
    private func prepare() {
        self.selectionStyle = SelectionStyle.none
        self.backgroundColor = .clear

        stackView.axis = .horizontal
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        let visibilityWidget = VisibilityWidget()
        self.visibilityWidget = visibilityWidget
        visibilityWidget.setRoundedCorners([.bottomLeft, .bottomRight])
        visibilityWidget.prepare()
        
        let pressureWidget = PressureWidget()
        self.pressureWidget = pressureWidget
        pressureWidget.setRoundedCorners([.bottomLeft, .bottomRight])
        pressureWidget.prepare()
        
        stackView.addArrangedSubview(visibilityWidget)
        stackView.addArrangedSubview(pressureWidget)
     }
}
