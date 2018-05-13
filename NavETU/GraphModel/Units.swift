//
//  Node.swift
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

class Node {
    let number: Int? // if it is an auditorium
    let coordinates: Point
    let neighbours: [Node]
    let edges: [Edge]
    
    init(number: Int = -1, coordinates: Point, nodes: [Node], edges: [Edge]) {
        self.number = number
        self.coordinates = coordinates
        neighbours = nodes
        self.edges = edges
    }
}
