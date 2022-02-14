//
//  PressureWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit



class PressureWidget: ViewWithRoundedCorner {
    
    struct PressureStringValue {
        let pressureValue: String
    }
    
    let pressureValueLabel = UILabel()
    let backgroundImageView = UIImageView()
    let arrowImageView = UIImageView()
    
    func prepare() {
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.image = UIImage(named: "barometer")
    
        self.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().inset(10)
        }
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.image = UIImage(named: "arrowBar")
        arrowImageView.backgroundColor = .brown.withAlphaComponent(0.2)
    }
    
    func setData(data: PressureStringValue) {
        pressureValueLabel.text = data.pressureValue
        arrowImageView.transform = arrowImageView.transform.rotated(by: CGFloat(0) * .pi / 180 )
    }
}
