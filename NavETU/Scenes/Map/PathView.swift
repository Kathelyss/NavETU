//
//  PathView.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 18.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class PathView: UIView {
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("no context found")
            return
        }
        
        let lineWidth = CGFloat(15.0)
        context.setLineWidth(lineWidth)
        let startingPoint = CGPoint(x: 0, y: rect.size.height - lineWidth)
        let endingPoint = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        context.move(to: startingPoint)
        context.addLine(to: endingPoint)
        context.setStrokeColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        context.strokePath()
    }
}
