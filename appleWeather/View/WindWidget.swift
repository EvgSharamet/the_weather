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

        backgroundImageView.backgroundColor = .red.withAlphaComponent(0.3)
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print(backgroundImageView.frame)
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    func setData(text: String) {
        backgroundImageView.image = UIImage(named: "nigth")
        textLabel.text = text
    }
}
