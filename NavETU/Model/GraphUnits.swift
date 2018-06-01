//
//  GraphUnits.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 13.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation
import CoreGraphics

struct Point: Codable {
    let x: CGFloat
    let y: CGFloat
}

class Node: Hashable, Codable, CustomStringConvertible {
    var hashValue: Int {
        return name.hashValue
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.name == rhs.name
    }
    
    let name: String
    let coordinates: Point
    let floor: Int
    var edges: [Edge] = []
    var description: String {
        return "\(name) - (x: \(coordinates.x), y: \(coordinates.y)), этаж: \(floor)"
    }
    
    init(name: String, coordinates: Point, floor: Int) {
        self.name = name
        self.coordinates = coordinates
        self.floor = floor
    }
    
    func connectTo(node: Node, edgeLength: Int, edgeWeight: Int) {
        self.edges.append(Edge(first: self, second: node, length: edgeLength, weight: edgeWeight))
        node.edges.append(Edge(first: node, second: self, length: edgeLength, weight: edgeWeight))
    }
    
}

class Edge: Codable, CustomStringConvertible {
    let firstNode: Node
    let secondNode: Node
    let length: Int
    let weight: Int? //for stairs
    var description: String {
        return "\(firstNode.name) - > \(secondNode.name) = \(length)"
    }
    
    init(first: Node, second: Node, length: Int, weight: Int?) {
        firstNode = first
        secondNode = second
        self.length = length
        self.weight = weight
    }
}

class Floor {
    public let number: Int
    public var nodes: [Node]
    
    init(number: Int, nodes: [Node]) {
        self.number = number
        self.nodes = nodes
    }
}

class Building {
    public let floors: [Floor]
    
    init(floors: [Floor]) {
        self.floors = floors
    }
}

class Path {
    public let totalLength: Int
    public let node: Node
    public let previousPath: Path?
    
    var nodes: [Node] {
        var nodes: [Node] = [self.node]
        var iterativePath = self
        while let path = iterativePath.previousPath {
            nodes.append(path.node)
            iterativePath = path
        }
        return nodes
    }
 
    init(to node: Node, via edge: Edge? = nil, previousPath path: Path? = nil) {
        if let previousPath = path, let viaEdge = edge {
            self.totalLength = viaEdge.length + previousPath.totalLength
        } else {
            self.totalLength = 0
        }
        self.node = node
        self.previousPath = path
    }
    
}
