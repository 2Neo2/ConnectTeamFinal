//
//  CustomTabBar.swift
//  ConnectTeam
//
//  Created by Иван Доронин on 26.03.2024.
//

import UIKit

final class CustomTabBar: UITabBar {
    private var shapeLayer: CALayer? = nil
    
    override func draw(_ rect: CGRect) {
        drawTabBar()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event)
        if pointIsInside == false {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return pointIsInside
    }
    
    
    private func drawTabBar() {
        let path : UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 1
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = Constants.Colors.backgroundColor?.cgColor
        self.layer.insertSublayer(shape, at: 0)
        self.itemWidth = 40
        self.itemPositioning = .centered
        self.itemSpacing = 210
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shape)
        } else {
            self.layer.insertSublayer(shape, at: 0)
        }

        self.shapeLayer = shape
    }
    
    
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.bounds.width
        let frameHeight = self.bounds.height + 50
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path : UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0))
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2))
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4))
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0))
        path.addLine(to: CGPoint(x: frameWidth, y: 0))
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight))
        path.addLine(to: CGPoint(x: 0, y: frameHeight))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        return path
    }
}
