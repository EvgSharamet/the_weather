//
//  ViewWithRoundedCorner.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 25.01.2022.
//

import Foundation
import UIKit


class ViewWithRoundedCorner: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
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
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 15.0, height: 0.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
