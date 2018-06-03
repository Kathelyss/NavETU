//
//  PathView.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 18.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

struct Constant {
    public static let xCellCount = CGFloat(37.5)
    public static let yCellCount = CGFloat(57)
}

class PathView: UIView {
    public var allPathNodes: [Node] = []
    public var currentFloorNumber: Int = 0 {
        didSet {
            let tmpAllNodes = allPathNodes
            let currentFloorNodes: [Node] = tmpAllNodes.filter { $0.floor - 1 == currentFloorNumber }
            nodes = currentFloorNodes
        }
    }
    
    var nodes: [Node] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    lazy var startView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let image = #imageLiteral(resourceName: "icon_start_pin")
        view.image = image.withRenderingMode(.alwaysTemplate)
        view.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        self.addSubview(view)
        return view
    }()
    
    lazy var endView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 45))
        let image = #imageLiteral(resourceName: "icon_end_pin")
        view.image = image.withRenderingMode(.alwaysTemplate)
        view.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.addSubview(view)
        return view
    }()
    
    let lineWidth = CGFloat(5)
    
    public override func draw(_ rect: CGRect) {
        guard nodes.isEmpty == false, allPathNodes.isEmpty == false else { return }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }
        
        context.setLineWidth(lineWidth)
        
        let startPoint = getCoordinates(for: nodes[0])
        context.move(to: startPoint)
        var nextPoint = CGPoint(x: 0, y: 0)
        for i in 1..<nodes.count {
            nextPoint = getCoordinates(for: nodes[i])
            context.addLine(to: nextPoint)
        }
        
        context.setStrokeColor(#colorLiteral(red: 0, green: 0.1826862782, blue: 0.7505155457, alpha: 0.4952910959))
        context.setLineCap(.round)
        context.setLineDash(phase: CGFloat(10), lengths: [CGFloat(15), CGFloat(10)])
        context.strokePath()
        if let first = nodes.first, let pathStart = allPathNodes.first, first != pathStart {
            drawCircle(nodeLocation: getCoordinates(for: first))
        }
        if let last = nodes.last, let pathEnd = allPathNodes.last, last != pathEnd, nodes.count > 1 {
            drawArrow(penultimateNodeLocation: getCoordinates(for: nodes[nodes.count - 2]),
                      lastNodeLocation: getCoordinates(for: last))
        }
    }
    
    func drawCircle(nodeLocation: CGPoint) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }
        
        context.setLineWidth(5)
        context.move(to: nodeLocation)
        let radius = CGFloat(8)
        context.addEllipse(in: CGRect(x: nodeLocation.x - radius,
                                      y: nodeLocation.y - radius,
                                      width: radius * 2,
                                      height: radius * 2))
        context.setFillColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        context.fillPath()
    }
    
    func drawArrow(penultimateNodeLocation: CGPoint, lastNodeLocation: CGPoint) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }
        
        var firstPoint = CGPoint(x: 0, y: 0)
        var secondPoint = CGPoint(x: 0, y: 0)
        context.setLineWidth(lineWidth)
        let arrowOffset = CGFloat(8)
        if lastNodeLocation.x < penultimateNodeLocation.x {
            firstPoint = CGPoint(x: lastNodeLocation.x + arrowOffset, y: lastNodeLocation.y + arrowOffset)
            secondPoint = CGPoint(x: lastNodeLocation.x + arrowOffset, y: lastNodeLocation.y - arrowOffset)
            //to left
        } else if lastNodeLocation.x > penultimateNodeLocation.x {
            firstPoint = CGPoint(x: lastNodeLocation.x - arrowOffset, y: lastNodeLocation.y + arrowOffset)
            secondPoint = CGPoint(x: lastNodeLocation.x - arrowOffset, y: lastNodeLocation.y - arrowOffset)
            //to right
        } else if lastNodeLocation.y < penultimateNodeLocation.y {
            firstPoint = CGPoint(x: lastNodeLocation.x - arrowOffset, y: lastNodeLocation.y + arrowOffset)
            secondPoint = CGPoint(x: lastNodeLocation.x + arrowOffset, y: lastNodeLocation.y + arrowOffset)
            //up
        } else if lastNodeLocation.y > penultimateNodeLocation.y {
            firstPoint = CGPoint(x: lastNodeLocation.x - arrowOffset, y: lastNodeLocation.y - arrowOffset)
            secondPoint = CGPoint(x: lastNodeLocation.x + arrowOffset, y: lastNodeLocation.y - arrowOffset)
            //down
        }
        context.setLineCap(.round)
        context.move(to: firstPoint)
        context.addLine(to: lastNodeLocation)
        context.addLine(to: secondPoint)
        
        context.setStrokeColor(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        context.strokePath()
    }
    
    func getCoordinates(for node: Node) -> CGPoint {
        let xMultiplier = bounds.size.width / Constant.xCellCount
        let yMultiplier = bounds.size.height / Constant.yCellCount
        return CGPoint(x: node.coordinates.x * xMultiplier + lineWidth,
                       y: node.coordinates.y * yMultiplier + lineWidth)
    }
}

