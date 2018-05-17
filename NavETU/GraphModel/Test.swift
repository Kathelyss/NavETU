//
//  Test.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 16.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation
import UIKit

class MyNode {
    let name: String
    var visited = false
    var connections: [Connection] = []
    
    init(name: String) {
        self.name = name
    }
    
    func connectTo(node: MyNode, weight: Int) {
        self.connections.append(Connection(to: node, weight: weight))
        node.connections.append(Connection(to: self, weight: weight))
    }
}

class Connection {
    public let to: MyNode
    public let weight: Int
    
    public init(to node: MyNode, weight: Int) {
        assert(weight >= 0, "weight has to be equal or greater than zero")
        self.to = node
        self.weight = weight
    }
}

class Path {
    public let cumulativeWeight: Int
    public let node: MyNode
    public let previousPath: Path?
    
    init(to node: MyNode, via connection: Connection? = nil, previousPath path: Path? = nil) {
        if let previousPath = path, let viaConnection = connection {
            self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
        } else {
            self.cumulativeWeight = 0
        }
        
        self.node = node
        self.previousPath = path
    }
}

extension Path {
    var array: [MyNode] {
        var array: [MyNode] = [self.node]
        
        var iterativePath = self
        while let path = iterativePath.previousPath {
            array.append(path.node)
            
            iterativePath = path
        }
        
        return array
    }
}

func shortestPath(from source: MyNode, to destination: MyNode) -> Path? {
    var frontier: [Path] = [] {
        didSet {
            frontier.sort { return $0.cumulativeWeight < $1.cumulativeWeight } // the frontier has to be always ordered
        }
    }
    
    frontier.append(Path(to: source)) // the frontier is made by a path that starts nowhere and ends in the source
    
    while !frontier.isEmpty {
        let cheapestPathInFrontier = frontier.removeFirst() // getting the cheapest path available
        guard !cheapestPathInFrontier.node.visited else { continue } // making sure we haven't visited the node already
        
        if cheapestPathInFrontier.node === destination {
            return cheapestPathInFrontier // found the cheapest path 😎
        }
        
        cheapestPathInFrontier.node.visited = true
        
        for connection in cheapestPathInFrontier.node.connections where !connection.to.visited { // adding new paths to our frontier
            frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
        }
    }
    return nil
}

func createNodesAndFindPath() {
    let nodes = createNodes()
    findPath(from: nodes[16-1], to: nodes[4-1])
}

func createNodes() -> [MyNode] {
    let node1 = MyNode(name: "(Entrance)")
    let node2 = MyNode(name: "1️⃣")
    let node3 = MyNode(name: "2️⃣")
    let node4 = MyNode(name: "3️⃣")
    let node5 = MyNode(name: "4️⃣")
    let node6 = MyNode(name: "6")
    let node7 = MyNode(name: "7")
    let node8 = MyNode(name: "8")
    let node9 = MyNode(name: "9")
    let node10 = MyNode(name: "10")
    let node11 = MyNode(name: "11📶")
    
    let node12 = MyNode(name: "12📶")
    let node13 = MyNode(name: "5️⃣")
    let node14 = MyNode(name: "6️⃣")
    let node15 = MyNode(name: "7️⃣")
    let node16 = MyNode(name: "8️⃣")
    let node17 = MyNode(name: "9️⃣")
    let node18 = MyNode(name: "🔟")
    let node19 = MyNode(name: "19")
    let node20 = MyNode(name: "20")
    let node21 = MyNode(name: "21")
    
    node1.connectTo(node: node7, weight: 3)
    node2.connectTo(node: node6, weight: 1)
    node4.connectTo(node: node6, weight: 1)
    node6.connectTo(node: node7, weight: 2)
    node7.connectTo(node: node8, weight: 8)
    node8.connectTo(node: node9, weight: 1)
    node9.connectTo(node: node10, weight: 1)
    node5.connectTo(node: node9, weight: 1)
    node3.connectTo(node: node10, weight: 1)
    node8.connectTo(node: node11, weight: 1)
    node11.connectTo(node: node12, weight: 3) //stairs
    node12.connectTo(node: node19, weight: 1)
    node19.connectTo(node: node15, weight: 3)
    node15.connectTo(node: node13, weight: 1)
    node15.connectTo(node: node16, weight: 2)
    node19.connectTo(node: node17, weight: 1)
    node19.connectTo(node: node20, weight: 2)
    node20.connectTo(node: node21, weight: 1)
    node20.connectTo(node: node18, weight: 2)
    node14.connectTo(node: node21, weight: 1)
    return [node1, node2, node3, node4, node5, node6, node7, node8, node9, node10,
            node11, node12, node13, node14, node15, node16, node17, node18, node19, node20, node21]
}

func findPath(from source: MyNode, to destination: MyNode) {
    let path = shortestPath(from: source, to: destination)
    if let path = path {
        let quickestPath: [String] = path.array.reversed().compactMap({$0}).map({$0.name})
        let res = quickestPath.reduce("") { text, node in "\(text)➝\(node)"}
        print("Quickest path: \(res), summary weight = \(path.cumulativeWeight / 2)")
    } else {
        print("No path found")
    }
}

////////

func createTestGraph() -> Building {
    let nodes = createTestNodes()
    let edge17 = Edge(first: nodes[1], second: nodes[7], length: 3, weight: 1)
    let edge26 = Edge(first: nodes[2], second: nodes[6], length: 1, weight: 1)
    let edge46 = Edge(first: nodes[4], second: nodes[6], length: 1, weight: 1)
    let edge67 = Edge(first: nodes[6], second: nodes[7], length: 1, weight: 1)
    let edge78 = Edge(first: nodes[7], second: nodes[8], length: 1, weight: 1)
    let edge89 = Edge(first: nodes[8], second: nodes[9], length: 1, weight: 1)
    let edge910 = Edge(first: nodes[9], second: nodes[10], length: 1, weight: 1)
    let edge59 = Edge(first: nodes[5], second: nodes[9], length: 1, weight: 1)
    let edge310 = Edge(first: nodes[3], second: nodes[10], length: 1, weight: 1)
    let edge811 = Edge(first: nodes[8], second: nodes[11], length: 1, weight: 1)
    //
    let edge1112 = Edge(first: nodes[11], second: nodes[12], length: 1, weight: 1)
    //
    let edge1219 = Edge(first: nodes[12], second: nodes[19], length: 1, weight: 1)
    let edge1315 = Edge(first: nodes[13], second: nodes[15], length: 1, weight: 1)
    let edge1516 = Edge(first: nodes[15], second: nodes[16], length: 1, weight: 1)
    let edge1519 = Edge(first: nodes[15], second: nodes[19], length: 1, weight: 1)
    let edge1917 = Edge(first: nodes[19], second: nodes[17], length: 1, weight: 1)
    let edge1920 = Edge(first: nodes[19], second: nodes[20], length: 1, weight: 1)
    let edge1820 = Edge(first: nodes[18], second: nodes[20], length: 1, weight: 1)
    let edge2021 = Edge(first: nodes[20], second: nodes[21], length: 1, weight: 1)
    let edge1421 = Edge(first: nodes[14], second: nodes[21], length: 1, weight: 1)
    let edges1 = [edge17, edge26, edge46, edge67, edge78, edge89, edge910, edge59, edge310, edge811]
    let edges2 = [edge1219, edge1315, edge1516, edge1519, edge1917, edge1920, edge1820, edge2021, edge1421]
    
    return Building(floors: [Floor(number: 1, edges: edges1),
                             Floor(number: 2, edges: edges2)])
}

func createTestNodes() -> [Node] {
    let initialEdges: [Edge] = []
    let node1 = Node(type: .exit, number: nil, coordinates: Point(x: 4, y: 1), edges: initialEdges)
    let node2 = Node(type: .auditorium, number: 1, coordinates: Point(x: 2, y: 5), edges: initialEdges)
    let node3 = Node(type: .auditorium, number: 2, coordinates: Point(x: 7, y: 5), edges: initialEdges)
    let node4 = Node(type: .auditorium, number: 3, coordinates: Point(x: 2, y: 3), edges: initialEdges)
    let node5 = Node(type: .auditorium, number: 4, coordinates: Point(x: 6, y: 3), edges: initialEdges)
    let node6 = Node(type: .link, number: nil, coordinates: Point(x: 2, y: 4), edges: initialEdges)
    let node7 = Node(type: .link, number: nil, coordinates: Point(x: 4, y: 4), edges: initialEdges)
    let node8 = Node(type: .link, number: nil, coordinates: Point(x: 5, y: 4), edges: initialEdges)
    let node9 = Node(type: .link, number: nil, coordinates: Point(x: 6, y: 4), edges: initialEdges)
    let node10 = Node(type: .link, number: nil, coordinates: Point(x: 7, y: 4), edges: initialEdges)
    let node11 = Node(type: .stairs, number: nil, coordinates: Point(x: 5, y: 5), edges: initialEdges)
    let node12 = Node(type: .stairs, number: nil, coordinates: Point(x: 4, y: 5), edges: initialEdges)
    let node13 = Node(type: .auditorium, number: 5, coordinates: Point(x: 3, y: 5), edges: initialEdges)
    let node14 = Node(type: .auditorium, number: 6, coordinates: Point(x: 7, y: 5), edges: initialEdges)
    let node15 = Node(type: .auditorium, number: 7, coordinates: Point(x: 3, y: 4), edges: initialEdges)
    let node16 = Node(type: .auditorium, number: 8, coordinates: Point(x: 3, y: 2), edges: initialEdges)
    let node17 = Node(type: .auditorium, number: 9, coordinates: Point(x: 4, y: 2), edges: initialEdges)
    let node18 = Node(type: .auditorium, number: 10, coordinates: Point(x: 6, y: 2), edges: initialEdges)
    let node19 = Node(type: .link, number: nil, coordinates: Point(x: 4, y: 4), edges: initialEdges)
    let node20 = Node(type: .link, number: nil, coordinates: Point(x: 6, y: 4), edges: initialEdges)
    let node21 = Node(type: .link, number: nil, coordinates: Point(x: 7, y: 4), edges: initialEdges)
    return [node1, node2, node3, node4, node5, node6, node7, node8, node9, node10,
            node11, node12, node13, node14, node15, node16, node17, node18, node19, node20, node21]
    
}

