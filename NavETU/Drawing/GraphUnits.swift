//
//  GraphUnits.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 13.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

struct Point {
    let x: Double
    let y: Double
}

enum NodeType {
    case exit, auditorium, link, stairs
}

class Node {
    let type: NodeType
    let name: String // if it is an auditorium
    let coordinates: Point
    var isVisited: Bool = false
    var edges: [Edge] = []
    
    init(type: NodeType, name: String, coordinates: Point, edges: [Edge]) {
        self.type = type
        self.name = name
        self.coordinates = coordinates
        self.edges = edges
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
    let number: Int
    let edges: [Edge]
    
    init(number: Int, edges: [Edge]) {
        self.number = number
        self.edges = edges
    }
}

class Path {
    public let totalLength: Int
    public let node: Node
    public let previousPath: Path?
    
    var array: [Node] {
        var array: [Node] = [self.node]
        var iterativePath = self
        while let path = iterativePath.previousPath {
            array.append(path.node)
            iterativePath = path
        }
        return array
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

class Building {
    let floors: [Floor]
    
    init(floors: [Floor]) {
        self.floors = floors
    }
}
