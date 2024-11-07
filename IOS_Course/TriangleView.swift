//
//  TriangleView.swift
//  IOS_Course
//
//  Created by Данила Казмирук on 03.11.2024.
//

import UIKit

extension ViewController {
    func addTriangleOverlay() {
        let shapeLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        
        let startPoint = CGPoint(x: -58, y: 900)
        let secondPoint = CGPoint(x: 500, y: 900)
        let thirdPoint = CGPoint(x: view.bounds.midX+255, y: view.bounds.midY-170)
        
        trianglePath.move(to: startPoint)
        trianglePath.addLine(to: secondPoint)
        trianglePath.addLine(to: thirdPoint)
        trianglePath.close()
        
        shapeLayer.path = trianglePath.cgPath
        shapeLayer.fillColor = UIColor.customRedOne.cgColor
        
        view.layer.addSublayer(shapeLayer)
    }
}
 
