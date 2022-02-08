//
//  WindWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 27.01.2022.
//

import Foundation
import SnapKit
import UIKit



class WindWidget: ViewWithRoundedCorner {
    let textLabel = UILabel()
    let backgroundImageView = UIImageView()
    let arrowImageView = UIImageView()
    
    func prepare() {
        
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        backgroundImageView.contentMode = .scaleAspectFit
        
        self.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(100)
        }
        arrowImageView.contentMode = .scaleAspectFit
    }
    
    func setData(text: String) {
        backgroundImageView.image = UIImage(named: "compass")
        backgroundImageView.alpha = 0.5
        arrowImageView.image = UIImage(named: "arrow")
        textLabel.text = text
    }
}
