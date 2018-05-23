//
//  PathView.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 18.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

struct Constant {
    public static let cellCount = CGFloat(21.0)
}

class PathView: UIView {
    public var allPathNodes: [Node] = []
    public var currentFloorNumber: Int = 0 {
        didSet {
            let tmpAllNodes = allPathNodes
            let currentFloorNodes: [Node] = tmpAllNodes.filter { $0.floor == currentFloorNumber }
            nodes = currentFloorNodes
        }
    }
    
    var nodes: [Node] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override func draw(_ rect: CGRect) {
        guard nodes.isEmpty == false else { return }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }
        
//        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let lineWidth = CGFloat(15)
        let offset = lineWidth / 2
        context.setLineWidth(lineWidth)
        let xMultiplier = rect.size.width / Constant.cellCount
        let yMultiplier = rect.size.height / Constant.cellCount
        let startPoint = CGPoint(x: nodes[0].coordinates.x * xMultiplier + offset,
                                    y: rect.size.height - (nodes[0].coordinates.y * yMultiplier - offset))
        context.move(to: startPoint)
        var nextPoint = CGPoint(x: 0, y: 0)
        for i in 1..<nodes.count {
            nextPoint = CGPoint(x: (nodes[i].coordinates.x) * xMultiplier + offset,
                                y: rect.size.height - (nodes[i].coordinates.y) * yMultiplier - offset)
            context.addLine(to: nextPoint)
        }
        
//        let firstNodeInPath = allPathNodes[0]
//        let lastNodeInPath = allPathNodes[allPathNodes.count - 1]
//        drawStartCircle(centerPoint: CGPoint(x: firstNodeInPath.coordinates.x * xMultiplier + offset,
//                                             y: rect.size.height - (firstNodeInPath.coordinates.y * yMultiplier - offset)))
//        drawEndPin(context: context,
//                   endPoint: CGPoint(x: lastNodeInPath.coordinates.x * xMultiplier + offset,
//                                     y: rect.size.height - (lastNodeInPath.coordinates.y * yMultiplier - offset)))
//
        context.setStrokeColor(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        context.strokePath()
    }
    
    func drawStartCircle(centerPoint: CGPoint) {
        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: 25,
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        shapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        shapeLayer.lineWidth = 5.0
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawEndPin(context: CGContext, endPoint: CGPoint) {
        let pen: CGPoint = endPoint
        context.move(to: pen)
        context.addLine(to: CGPoint(x: pen.x - 15, y: pen.y - 25))
        let controlP = CGPoint(x: pen.x, y: pen.y - 45)
        context.addQuadCurve(to: CGPoint(x: pen.x + 15, y: pen.y - 25), control: controlP)
        context.addLine(to: pen)
        context.closePath()
//        context.setFillColor(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1).cgColor)
//        context.setStrokeColor(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor)
//        context.setLineWidth(CGFloat(5.0))
    }
}

