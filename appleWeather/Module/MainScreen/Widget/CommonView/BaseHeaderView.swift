//
//  HeaderViewWithRoundedCorner.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 26.01.2022.
//

import Foundation
import SnapKit
import UIKit


class BaseHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
        self.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15.0, height: 0.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
