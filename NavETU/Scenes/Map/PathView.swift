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
            let currentFloorNodes: [Node] = allPathNodes.filter { $0.floor == currentFloorNumber }
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
        
        let lineWidth = CGFloat(20)
        context.setLineWidth(lineWidth)
        let xMultiplier = rect.size.width / Constant.cellCount
        let yMultiplier = rect.size.height / Constant.cellCount
        let startingPoint = CGPoint(x: (nodes[0].coordinates.x) * xMultiplier + lineWidth / 2,
                                    y: rect.size.height - (nodes[0].coordinates.y) * yMultiplier - lineWidth / 2)
        context.move(to: startingPoint)
        var nextPoint = CGPoint(x: 0, y: 0)
        for i in 1..<nodes.count {
            nextPoint = CGPoint(x: (nodes[i].coordinates.x) * xMultiplier + lineWidth / 2,
                                y: rect.size.height - (nodes[i].coordinates.y) * yMultiplier - lineWidth / 2)
            context.addLine(to: nextPoint)
        }
        context.setStrokeColor(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
        context.strokePath()
    }
}
