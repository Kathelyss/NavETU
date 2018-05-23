//
//  MapDataSource.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 18.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import Foundation
import UIKit

struct SearchFields {
    var sourceNodeIndex: Int
    var destinationNodeIndex: Int
}

class MapDataSource {
    let mapImages: [UIImage] = [#imageLiteral(resourceName: "floor1"), #imageLiteral(resourceName: "floor2"), #imageLiteral(resourceName: "floor3"), #imageLiteral(resourceName: "floor4"), #imageLiteral(resourceName: "floor5"), #imageLiteral(resourceName: "floor6")]
    var buildingGraph: Building!
    var allNodes: [Node] = []
    var path: [Node] = []
    
    init() {
        buildingGraph = createBuildingGraph()
        allNodes = Array(buildingGraph.floors.compactMap({$0.nodes}).joined())
    }
    
    func createBuildingGraph() -> Building {
        let node0 = Node(name: "0", coordinates: Point(x: 11, y: 0), floor: 0)
        let node1 = Node(name: "1", coordinates: Point(x: 4, y: 13), floor: 0)
        let node2 = Node(name: "2", coordinates: Point(x: 20, y: 13), floor: 0)
        let node3 = Node(name: "3", coordinates: Point(x: 4, y: 7), floor: 0)
        let node4 = Node(name: "4", coordinates: Point(x: 17, y: 7), floor: 0)
        let node5 = Node(name: "5", coordinates: Point(x: 6, y: 13), floor: 1)
        let node6 = Node(name: "6", coordinates: Point(x: 19, y: 13), floor: 1)
        let node7 = Node(name: "7", coordinates: Point(x: 6, y: 9), floor: 1)
        let node8 = Node(name: "8", coordinates: Point(x: 6, y: 4), floor: 1)
        let node9 = Node(name: "9", coordinates: Point(x: 10, y: 4), floor: 1)
        let node10 = Node(name: "10", coordinates: Point(x: 15, y: 4), floor: 1)
        let node11 = Node(name: "11", coordinates: Point(x: 4, y: 10), floor: 0)
        let node12 = Node(name: "12", coordinates: Point(x: 11, y: 10), floor: 0)
        let node13 = Node(name: "13", coordinates: Point(x: 13, y: 10), floor: 0)
        let node14 = Node(name: "14", coordinates: Point(x: 17, y: 10), floor: 0)
        let node15 = Node(name: "15", coordinates: Point(x: 20, y: 10), floor: 0)
        let node16 = Node(name: "16📶", coordinates: Point(x: 13, y: 19), floor: 0)
        let node17 = Node(name: "17📶", coordinates: Point(x: 10, y: 19), floor: 1)
        let node18 = Node(name: "18", coordinates: Point(x: 10, y: 9), floor: 1)
        let node19 = Node(name: "19", coordinates: Point(x: 15, y: 9), floor: 1)
        let node20 = Node(name: "20", coordinates: Point(x: 19, y: 9), floor: 1)
        
        node0.connectTo(node: node12, edgeLength: 10, edgeWeight: 1)
        node1.connectTo(node: node11, edgeLength: 3, edgeWeight: 1)
        node3.connectTo(node: node11, edgeLength: 3, edgeWeight: 1)
        node11.connectTo(node: node12, edgeLength: 7, edgeWeight: 1)
        node12.connectTo(node: node13, edgeLength: 2, edgeWeight: 1)
        node13.connectTo(node: node14, edgeLength: 4, edgeWeight: 1)
        node13.connectTo(node: node16, edgeLength: 9, edgeWeight: 1)
        node14.connectTo(node: node4, edgeLength: 3, edgeWeight: 1)
        node14.connectTo(node: node15, edgeLength: 3, edgeWeight: 1)
        node15.connectTo(node: node2, edgeLength: 3, edgeWeight: 1)
        node16.connectTo(node: node17, edgeLength: 3, edgeWeight: 1) //stairs
        node17.connectTo(node: node18, edgeLength: 10, edgeWeight: 1)
        node18.connectTo(node: node7, edgeLength: 4, edgeWeight: 1)
        node18.connectTo(node: node9, edgeLength: 5, edgeWeight: 1)
        node18.connectTo(node: node19, edgeLength: 5, edgeWeight: 1)
        node7.connectTo(node: node5, edgeLength: 4, edgeWeight: 1)
        node7.connectTo(node: node8, edgeLength: 5, edgeWeight: 1)
        node19.connectTo(node: node10, edgeLength: 5, edgeWeight: 1)
        node19.connectTo(node: node20, edgeLength: 4, edgeWeight: 1)
        node20.connectTo(node: node6, edgeLength: 4, edgeWeight: 1)
        
        let floor1 = Floor(number: 1, nodes: [node0, node1, node2, node3, node4,
                                              node11, node12, node13, node14, node15, node16])
        let floor2 = Floor(number: 2, nodes: [node5, node6, node7, node8, node9,
                                              node10, node17, node18, node19, node20])
        return Building(floors: [floor1, floor2])
    }
    
    func dijkstraAlgorithm(from source: Node, to destination: Node) -> Path? {
        var visitedNodes: Set<Node> = []
        var frontier: [Path] = [] {
            didSet {
                frontier.sort { return $0.totalLength < $1.totalLength } // the frontier has to be always ordered
            }
        }
        frontier.append(Path(to: source)) // the frontier = path that starts nowhere and ends in the source
        while !frontier.isEmpty {
            let cheapestPathInFrontier = frontier.removeFirst()
            guard !visitedNodes.contains(cheapestPathInFrontier.node) else { continue }
            visitedNodes.insert(cheapestPathInFrontier.node)
            
            if cheapestPathInFrontier.node === destination {
                return cheapestPathInFrontier
            }
            for connection in cheapestPathInFrontier.node.edges where !visitedNodes.contains(connection.secondNode) {
                frontier.append(Path(to: connection.secondNode, via: connection, previousPath: cheapestPathInFrontier))
            }
        }
        return nil
    }
    
    func findPath(in building: [Node], from sourceNodeName: String, to destinationNodeName: String) -> [Node] {
        let sourceNode = building.filter( { $0.name == sourceNodeName }).first
        let destinationNode = building.filter( { $0.name == destinationNodeName }).first
        guard let source = sourceNode, let destination = destinationNode else {
            print("No path found!")
            return []
        }
        
        let path = dijkstraAlgorithm(from: source, to: destination)
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
}
