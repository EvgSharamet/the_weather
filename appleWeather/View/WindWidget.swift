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
    
    func prepare() {
        
        self.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        backgroundImageView.contentMode = .scaleAspectFit
    }
    
    func setData(text: String) {
        backgroundImageView.image = UIImage(named: "compass")
        backgroundImageView.alpha = 0.5
        textLabel.text = text
    }
}
