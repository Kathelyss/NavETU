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

func findPath(in building: [Node], from sourceNodeNumber: Int, to destinationNodeNumber: Int) -> [Node] {
    let path = dijkstraAlgorithm(from: building[sourceNodeNumber - 1], to: building[destinationNodeNumber - 1])
    if let path = path {
        let pathNodeNamesArray: [String] = path.nodes.reversed().compactMap({$0}).map({$0.name})
        let resultString = pathNodeNamesArray.reduce("") { $0 + " ➝ " + $1 }
        print("Path: \(resultString), length = \(path.totalLength)")
        return path.nodes.reversed()
    } else {
        print("No path found")
        return []
    }
}

func createBuildingGraph() -> Building {
    let node1 = Node(type: .exit, name: "1", coordinates: Point(x: 11, y: 0), floor: 0)
    let node2 = Node(type: .auditorium, name: "1️⃣", coordinates: Point(x: 4, y: 13), floor: 0)
    let node3 = Node(type: .auditorium, name: "2️⃣", coordinates: Point(x: 20, y: 13), floor: 0)
    let node4 = Node(type: .auditorium, name: "3️⃣", coordinates: Point(x: 4, y: 7), floor: 0)
    let node5 = Node(type: .auditorium, name: "4️⃣", coordinates: Point(x: 17, y: 7), floor: 0)
    let node6 = Node(type: .link, name: "6", coordinates: Point(x: 4, y: 10), floor: 0)
    let node7 = Node(type: .link, name: "7", coordinates: Point(x: 11, y: 10), floor: 0)
    let node8 = Node(type: .link, name: "8", coordinates: Point(x: 13, y: 10), floor: 0)
    let node9 = Node(type: .link, name: "9", coordinates: Point(x: 17, y: 10), floor: 0)
    let node10 = Node(type: .link, name: "10", coordinates: Point(x: 20, y: 10), floor: 0)
    let node11 = Node(type: .stairs, name: "11📶", coordinates: Point(x: 13, y: 19), floor: 0)
    let node12 = Node(type: .stairs, name: "12📶", coordinates: Point(x: 10, y: 19), floor: 1)
    let node13 = Node(type: .auditorium, name: "5️⃣", coordinates: Point(x: 6, y: 13), floor: 1)
    let node14 = Node(type: .auditorium, name: "6️⃣", coordinates: Point(x: 19, y: 13), floor: 1)
    let node15 = Node(type: .auditorium, name: "7️⃣", coordinates: Point(x: 6, y: 9), floor: 1)
    let node16 = Node(type: .auditorium, name: "8️⃣", coordinates: Point(x: 6, y: 4), floor: 1)
    let node17 = Node(type: .auditorium, name: "9️⃣", coordinates: Point(x: 10, y: 4), floor: 1)
    let node18 = Node(type: .auditorium, name: "🔟", coordinates: Point(x: 15, y: 4), floor: 1)
    let node19 = Node(type: .link, name: "19", coordinates: Point(x: 10, y: 9), floor: 1)
    let node20 = Node(type: .link, name: "20", coordinates: Point(x: 15, y: 9), floor: 1)
    let node21 = Node(type: .link, name: "21", coordinates: Point(x: 19, y: 9), floor: 1)
    
    node1.connectTo(node: node7, edgeLength: 10, edgeWeight: 1)
    node2.connectTo(node: node6, edgeLength: 3, edgeWeight: 1)
    node4.connectTo(node: node6, edgeLength: 3, edgeWeight: 1)
    node6.connectTo(node: node7, edgeLength: 7, edgeWeight: 1)
    node7.connectTo(node: node8, edgeLength: 2, edgeWeight: 1)
    node8.connectTo(node: node9, edgeLength: 4, edgeWeight: 1)
    node8.connectTo(node: node11, edgeLength: 9, edgeWeight: 1)
    node9.connectTo(node: node5, edgeLength: 3, edgeWeight: 1)
    node9.connectTo(node: node10, edgeLength: 3, edgeWeight: 1)
    node10.connectTo(node: node3, edgeLength: 3, edgeWeight: 1)
    node11.connectTo(node: node12, edgeLength: 3, edgeWeight: 1) //stairs
    node12.connectTo(node: node19, edgeLength: 10, edgeWeight: 1)
    node19.connectTo(node: node15, edgeLength: 4, edgeWeight: 1)
    node19.connectTo(node: node17, edgeLength: 5, edgeWeight: 1)
    node19.connectTo(node: node20, edgeLength: 5, edgeWeight: 1)
    node15.connectTo(node: node13, edgeLength: 4, edgeWeight: 1)
    node15.connectTo(node: node16, edgeLength: 5, edgeWeight: 1)
    node20.connectTo(node: node18, edgeLength: 5, edgeWeight: 1)
    node20.connectTo(node: node21, edgeLength: 4, edgeWeight: 1)
    node21.connectTo(node: node14, edgeLength: 4, edgeWeight: 1)
    
    let floor1 = Floor(number: 1,
                       nodes: [node1, node2, node3, node4, node5,
                               node6, node7, node8, node9, node10, node11])
    let floor2 = Floor(number: 2,
                       nodes: [node12, node13, node14, node15, node16,
                               node17, node18, node19, node20, node21])
    
    return Building(floors: [floor1, floor2])
}
