//
//  GraphUnits.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 13.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation
import UIKit

struct Point {
    let x: CGFloat
    let y: CGFloat
}

enum NodeType {
    case exit, auditorium, link, stairs
}

class Node: Hashable {
    var hashValue: Int
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.name == rhs.name
    }
    
    let type: NodeType
    let name: String
    let coordinates: Point
    public let floor: Int
//    var isVisited: Bool = false
    var edges: [Edge] = []
    
    init(type: NodeType, name: String, coordinates: Point, floor: Int) {
        self.type = type
        self.name = name
        self.coordinates = coordinates
        self.floor = floor
        hashValue = name.hashValue
    }
    
    func connectTo(node: Node, edgeLength: Int, edgeWeight: Int) {
        self.edges.append(Edge(first: self, second: node, length: edgeLength, weight: edgeWeight))
        node.edges.append(Edge(first: node, second: self, length: edgeLength, weight: edgeWeight))
    }
}

class Edge {
    let firstNode: Node
    let secondNode: Node
    let length: Int
    let weight: Int? //for stairs
    
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
