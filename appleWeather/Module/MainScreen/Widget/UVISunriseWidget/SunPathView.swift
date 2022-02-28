//
//  SunPathView.swift
//  appleWeather
//
//  Created by Ruslan Klimaitis on 28.02.2022.
//

import UIKit

class SunPathView: UIView {
    private struct Const {
        static let lineWidth: CGFloat = 4.0
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     */
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawPathCurve(rect: rect, context: context)
        drawHorizont(rect: rect, context: context)
    }
    
    private func drawPathCurve(rect: CGRect, context: CGContext) {
        let startPoint = CGPoint(x: rect.minX, y: rect.maxY - Const.lineWidth)
        let endPoint = CGPoint(x: rect.maxX, y: rect.maxY - Const.lineWidth)
        let middlePoint = CGPoint(x: (endPoint.x - startPoint.x) / 2.0,
                                  y: rect.minY + Const.lineWidth)
        
        let curve = CGMutablePath()
        curve.move(to: startPoint)
        curve.addCurve(to: middlePoint,
                       control1: CGPoint(x: middlePoint.x * 0.33, y: curve.currentPoint.y),
                       control2: CGPoint(x: middlePoint.x * 0.66, y: middlePoint.y))
        curve.addCurve(to: endPoint,
                       control1: CGPoint(x: curve.currentPoint.x + (middlePoint.x * 0.33), y: curve.currentPoint.y),
                       control2: CGPoint(x: curve.currentPoint.x + (middlePoint.x * 0.66), y: endPoint.y))
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(Const.lineWidth)
        context.addPath(curve)
        context.strokePath()
    }
    
    private func drawHorizont(rect: CGRect, context: CGContext) {
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(Const.lineWidth / 2.0)
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        context.strokePath()
    }
}
