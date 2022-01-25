//
//  UVIWidget.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 24.01.2022.
//

import Foundation
import UIKit
import SnapKit



class UVIWidget: UIView {
    
    func prepare() {
        self.backgroundColor = .darkGray
        
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        let UVILabel = UILabel()
        stackView.addArrangedSubview(UVILabel)
        UVILabel.text = "UVI"
    }
}
