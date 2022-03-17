//
//
//  appleWeather
//
//  Created by Евгения Шарамет on 26.01.2022.
//

import Foundation
import UIKit


class BaseCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let backgroundImage = UIImageView()
        self.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundImage.image = UIImage(named: "backgroundForSectionDay")
        backgroundImage.alpha = 0.9
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
        self.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        blurEffectView.alpha = 0.5
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: 15.0, height: 0.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
