//
//  TriangleView.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 03.11.2024.
//

import UIKit
class TriangleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        addTriangleOverlay()
    }
    
    func addTriangleOverlay() {
        let shapeLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        
        let startPoint = CGPoint(x: bounds.minX, y: bounds.height)
        let secondPoint = CGPoint(x: bounds.width, y: bounds.height)
        let thirdPoint = CGPoint(x: bounds.width, y: bounds.midY*0.75)
        
        trianglePath.move(to: startPoint)
        trianglePath.addLine(to: secondPoint)
        trianglePath.addLine(to: thirdPoint)
        trianglePath.close()
        
        shapeLayer.path = trianglePath.cgPath
        shapeLayer.fillColor = UIColor.customRedOne.cgColor
        
        layer.sublayers?.removeAll(where: { $0 is CAShapeLayer })
        layer.addSublayer(shapeLayer)
    }
}

 
