//
//  WindWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit

class WindWidget: BaseWidgetView {
    struct WindStringValue {
         let windSpeed: String
         let windMeasure: String
         let windDeg: Int
    }

    let windSpeedLabel = UILabel()
    let windMeasureLabel = UILabel()
    let backgroundImageView = UIImageView()
    let arrowImageView = UIImageView()
    
    func prepare() {
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(10)
        }
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.image = UIImage(named: "compassWind")
        
        self.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().inset(15)
        }
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.image = UIImage(named: "arrowWind")
        
        let circleView = UIView()
        self.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(50)
        }
        circleView.layer.cornerRadius = 25
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        circleView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        circleView.layer.masksToBounds = true
        
        let centerStack = UIStackView()
        self.addSubview(centerStack)
        centerStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        centerStack.axis = .vertical
        centerStack.distribution = .fillProportionally
        centerStack.layer.cornerRadius = 20
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.font = windSpeedLabel.font.withSize(25)
        windSpeedLabel.textColor = .white
        windMeasureLabel.textAlignment = .center
        windMeasureLabel.textColor = .white
        windMeasureLabel.font = windMeasureLabel.font.withSize(16)
        centerStack.addArrangedSubview(windSpeedLabel)
        centerStack.addArrangedSubview(windMeasureLabel)
    }
    
    func configure(data: WindStringValue) {
        windSpeedLabel.text = data.windSpeed
        windMeasureLabel.text = data.windMeasure
        arrowImageView.transform = .identity
        arrowImageView.transform = arrowImageView.transform.rotated(by: CGFloat(data.windDeg) * .pi / 180 )
    }
}
