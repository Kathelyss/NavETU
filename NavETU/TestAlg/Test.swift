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

func dijkstraAlgorithm(from source: MyNode, to destination: MyNode) -> Path? {
    var frontier: [Path] = [] {
        didSet {
            frontier.sort { return $0.cumulativeWeight < $1.cumulativeWeight } // the frontier has to be always ordered
        }
    }
    
    frontier.append(Path(to: source)) // the frontier is made by a path that starts nowhere and ends in the source
    
    while !frontier.isEmpty {
        let cheapestPathInFrontier = frontier.removeFirst()
        guard !cheapestPathInFrontier.node.visited else { continue }
        
        if cheapestPathInFrontier.node === destination {
            return cheapestPathInFrontier
        }
        cheapestPathInFrontier.node.visited = true
        for connection in cheapestPathInFrontier.node.connections where !connection.to.visited {
            // adding new paths to our frontier
            frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
        }
    }
    return nil
}

func findPath(between sourceNodeNumber: Int, and destinationNodeNumber: Int) {
    let nodes = createNodes()
    let path = dijkstraAlgorithm(from: nodes[sourceNodeNumber - 1], to: nodes[destinationNodeNumber - 1])
    if let path = path {
        let quickestPath: [String] = path.array.reversed().compactMap({$0}).map({$0.name})
        let res = quickestPath.reduce("") { text, node in "\(text) ➝ \(node)"}
        print("Path: \(res), length = \(path.cumulativeWeight)")
    } else {
        print("No path found")
    }
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
    node7.connectTo(node: node8, weight: 1)
    node8.connectTo(node: node9, weight: 1)
    node9.connectTo(node: node10, weight: 1)
    node5.connectTo(node: node9, weight: 1)
    node3.connectTo(node: node10, weight: 1)
    node8.connectTo(node: node11, weight: 1)
    node11.connectTo(node: node12, weight: 3) //stairs
    node12.connectTo(node: node19, weight: 1)
    node19.connectTo(node: node15, weight: 1)
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
