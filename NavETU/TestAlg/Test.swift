//
//  Test.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 16.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation
import UIKit

func dijkstraAlgorithm(from source: Node, to destination: Node) -> Path? {
    var frontier: [Path] = [] {
        didSet {
            frontier.sort { return $0.totalLength < $1.totalLength } // the frontier has to be always ordered
        }
    }
    frontier.append(Path(to: source)) // the frontier = path that starts nowhere and ends in the source
    while !frontier.isEmpty {
        let cheapestPathInFrontier = frontier.removeFirst()
        guard cheapestPathInFrontier.node.isVisited == false else { continue }
        
        if cheapestPathInFrontier.node === destination {
            return cheapestPathInFrontier
        }
        cheapestPathInFrontier.node.isVisited = true
        for connection in cheapestPathInFrontier.node.edges where !connection.secondNode.isVisited {
            frontier.append(Path(to: connection.secondNode, via: connection, previousPath: cheapestPathInFrontier))
        }
    }
    return nil
}

func findPath(between sourceNodeNumber: Int, and destinationNodeNumber: Int) {
    let nodes = createNodes()
    let path = dijkstraAlgorithm(from: nodes[sourceNodeNumber - 1], to: nodes[destinationNodeNumber - 1])
    if let path = path {
        let pathNodeNamesArray: [String] = path.nodes.reversed().compactMap({$0}).map({$0.name})
        let resultString = pathNodeNamesArray.reduce("") { text, node in "\(text) ➝ \(node)"}
        print("Path: \(resultString), length = \(path.totalLength)")
    } else {
        print("No path found")
    }
}

func createNodes() -> [Node] {
    let initialEdges: [Edge] = []
    let node1 = Node(type: .exit, name: "1", coordinates: Point(x: 12, y: 1), edges: initialEdges)
    let node2 = Node(type: .auditorium, name: "1️⃣", coordinates: Point(x: 5, y: 14), edges: initialEdges)
    let node3 = Node(type: .auditorium, name: "2️⃣", coordinates: Point(x: 21, y: 14), edges: initialEdges)
    let node4 = Node(type: .auditorium, name: "3️⃣", coordinates: Point(x: 5, y: 8), edges: initialEdges)
    let node5 = Node(type: .auditorium, name: "4️⃣", coordinates: Point(x: 18, y: 8), edges: initialEdges)
    let node6 = Node(type: .link, name: "6", coordinates: Point(x: 5, y: 11), edges: initialEdges)
    let node7 = Node(type: .link, name: "7", coordinates: Point(x: 12, y: 11), edges: initialEdges)
    let node8 = Node(type: .link, name: "8", coordinates: Point(x: 14, y: 11), edges: initialEdges)
    let node9 = Node(type: .link, name: "9", coordinates: Point(x: 18, y: 11), edges: initialEdges)
    let node10 = Node(type: .link, name: "10", coordinates: Point(x: 21, y: 11), edges: initialEdges)
    let node11 = Node(type: .stairs, name: "11📶", coordinates: Point(x: 14, y: 14), edges: initialEdges)
    let node12 = Node(type: .stairs, name: "12📶", coordinates: Point(x: 11, y: 14), edges: initialEdges)
    let node13 = Node(type: .auditorium, name: "5️⃣", coordinates: Point(x: 7, y: 14), edges: initialEdges)
    let node14 = Node(type: .auditorium, name: "6️⃣", coordinates: Point(x: 20, y: 14), edges: initialEdges)
    let node15 = Node(type: .auditorium, name: "7️⃣", coordinates: Point(x: 7, y: 10), edges: initialEdges)
    let node16 = Node(type: .auditorium, name: "8️⃣", coordinates: Point(x: 7, y: 5), edges: initialEdges)
    let node17 = Node(type: .auditorium, name: "9️⃣", coordinates: Point(x: 11, y: 5), edges: initialEdges)
    let node18 = Node(type: .auditorium, name: "🔟", coordinates: Point(x: 16, y: 5), edges: initialEdges)
    let node19 = Node(type: .link, name: "19", coordinates: Point(x: 11, y: 10), edges: initialEdges)
    let node20 = Node(type: .link, name: "20", coordinates: Point(x: 16, y: 10), edges: initialEdges)
    let node21 = Node(type: .link, name: "21", coordinates: Point(x: 20, y: 10), edges: initialEdges)
    
    node1.connectTo(node: node7, edgeLength: 10, edgeWeight: 1)
    node2.connectTo(node: node6, edgeLength: 3, edgeWeight: 1)
    node4.connectTo(node: node6, edgeLength: 3, edgeWeight: 1)
    node6.connectTo(node: node7, edgeLength: 7, edgeWeight: 1)
    node7.connectTo(node: node8, edgeLength: 2, edgeWeight: 1)
    node8.connectTo(node: node9, edgeLength: 4, edgeWeight: 1)
    node8.connectTo(node: node11, edgeLength: 3, edgeWeight: 1)
    node9.connectTo(node: node5, edgeLength: 3, edgeWeight: 1)
    node9.connectTo(node: node10, edgeLength: 3, edgeWeight: 1)
    node10.connectTo(node: node3, edgeLength: 3, edgeWeight: 1)
    node11.connectTo(node: node12, edgeLength: 17, edgeWeight: 1) //stairs
    node12.connectTo(node: node19, edgeLength: 4, edgeWeight: 1)
    node19.connectTo(node: node15, edgeLength: 4, edgeWeight: 1)
    node19.connectTo(node: node17, edgeLength: 5, edgeWeight: 1)
    node19.connectTo(node: node20, edgeLength: 5, edgeWeight: 1)
    node15.connectTo(node: node13, edgeLength: 4, edgeWeight: 1)
    node15.connectTo(node: node16, edgeLength: 5, edgeWeight: 1)
    node20.connectTo(node: node18, edgeLength: 5, edgeWeight: 1)
    node20.connectTo(node: node21, edgeLength: 4, edgeWeight: 1)
    node21.connectTo(node: node14, edgeLength: 4, edgeWeight: 1)
    return [node1, node2, node3, node4, node5, node6, node7, node8, node9, node10,
            node11, node12, node13, node14, node15, node16, node17, node18, node19, node20, node21]
}
