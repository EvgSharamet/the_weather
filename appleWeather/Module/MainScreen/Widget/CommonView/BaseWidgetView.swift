//
//
//  appleWeather
//
//  Created by Евгения Шарамет on 26.01.2022.
//

import Foundation
import UIKit

class BaseWidgetView: UIView {
    private var roundedCorners: UIRectCorner = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        self.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    func setRoundedCorners(_ roundedCorners: UIRectCorner) {
        self.roundedCorners = roundedCorners
        setNeedsLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundedCorners,
                                cornerRadii: CGSize(width: 15.0, height: 0.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
