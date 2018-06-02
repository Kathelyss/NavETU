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
    
    let lineWidth = CGFloat(8)
    var offset: CGFloat {
        return lineWidth / 2
    }
    
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
        context.strokePath()
        if let first = nodes.first, let start = allPathNodes.first, first != start {
            drawCircle(nodeLocation: getCoordinates(for: first))
        }
    }
    
    func drawCircle(nodeLocation: CGPoint) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }
        
        context.move(to: nodeLocation)
        let radius = CGFloat(8)
        context.addEllipse(in: CGRect(x: nodeLocation.x - radius,
                                             y: nodeLocation.y - radius,
                                             width: radius * 2,
                                             height: radius * 2))
        context.setFillColor(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        context.fillPath()
    }
    
    func getCoordinates(for node: Node) -> CGPoint {
        let xMultiplier = bounds.size.width / Constant.cellCount
        let yMultiplier = bounds.size.height / Constant.cellCount
        return CGPoint(x: node.coordinates.x * xMultiplier + offset,
                       y: bounds.size.height - (node.coordinates.y * yMultiplier - offset))
    }
}

