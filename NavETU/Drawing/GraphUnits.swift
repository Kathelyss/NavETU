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
    case exit
    case auditorium
    case link
    case stairs
}

class Node {
    let type: NodeType
    let number: Int? // if it is an auditorium
    let coordinates: Point
    let edges: [Edge]?
    
    init(type: NodeType, number: Int?, coordinates: Point, edges: [Edge]?) {
        self.type = type
        self.number = number
        self.coordinates = coordinates
        self.edges = edges
    }
}

class Edge {
    let firstNode: Node
    let secondNode: Node
    let length: Double
    let weight: Double? //for stairs
    
    init(first: Node, second: Node, length: Double, weight: Double?) {
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

class Building {
    let floors: [Floor]
    
    init(floors: [Floor]) {
        self.floors = floors
    }
}
