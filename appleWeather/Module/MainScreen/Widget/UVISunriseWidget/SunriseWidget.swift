//
//  Sunrise.swift
//  appleWeather
//
//  Created by Евгения Шарамет on 26.01.2022.
//

import Foundation
import SnapKit
import UIKit


class SunriseWidget: ViewWithRoundedCorner {
    
    struct SunriseStringValue {
        let sunrise: Double
        let sunset: Double
        let sunriseValue: String
        let sunsetValue: String
    }
    
    let sunriseLabel = UILabel()
    let sunsetLabel = UILabel()
    let sunPathChart = SunPathView()
    
    func prepare() {
        sunPathChart.backgroundColor = .blue
        addSubview(sunPathChart)
        sunPathChart.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview().offset(50)
            maker.bottom.equalToSuperview().offset(-50)
        }
        
        let stackView = UIStackView()
        self.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(sunriseLabel)
        stackView.addArrangedSubview(sunsetLabel)
        
        backgroundColor = .red
    }
    
    func configure(data: SunriseStringValue) {
        sunriseLabel.text = data.sunriseValue
        sunsetLabel.text = data.sunsetValue
        
    }
    
    func addParabolaWithMax(maxPoint: CGPoint, inRect boundingRect: CGRect) -> UIBezierPath {

        func halfPoint1D(p0: CGFloat, p2: CGFloat, control: CGFloat) -> CGFloat {
            return 2 * control - p0 / 2 - p2 / 2
        }

        let path = UIBezierPath()

        let p0 = CGPoint(x: 0, y: boundingRect.maxY)
        let p2 = CGPoint(x: boundingRect.maxX, y: boundingRect.maxY)

        let p1 = CGPoint(x: halfPoint1D(p0: p0.x, p2: p2.x, control: maxPoint.x),
                         y: halfPoint1D(p0: p0.y, p2: p2.y, control: maxPoint.y))

        path.move(to: p0)
        path.addQuadCurve(to: p2, controlPoint: p1)
        return path
    }
}
