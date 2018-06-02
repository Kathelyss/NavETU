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

enum NavETUError: Error {
        case noSourceNode, noDestinationNode, noPathFound
}

class MapDataSource {
    let mapImages: [UIImage] = [#imageLiteral(resourceName: "floor1"), #imageLiteral(resourceName: "floor2"), #imageLiteral(resourceName: "floor5")]
    var buildingGraph: Building!
    var allNodes: [Node] = []
    var path: [Node] = []
    
    init() {
        buildingGraph = createBuildingGraph()
        allNodes = Array(buildingGraph.floors.compactMap({$0.nodes}).joined())
    }
    
    func parseNodes() throws -> [Node] {
        let url = Bundle.main.url(forResource: "nodes", withExtension: "plist")!
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try decoder.decode([Node].self, from: data)
    }
    
    func parseEdges() throws -> [EdgeSaver] {
        let url = Bundle.main.url(forResource: "edges", withExtension: "plist")!
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try decoder.decode([EdgeSaver].self, from: data)
    }
    
    func createBuildingGraph() -> Building {
        do {
            let nodes = try parseNodes()
            let edgeStrictures = try parseEdges()
            for structure in edgeStrictures {
                let firstNode = nodes.filter { $0.name == structure.firstNodeName }.first
                let secondNode = nodes.filter { $0.name == structure.secondNodeName }.first
                guard let first = firstNode, let second = secondNode else {
                    print("Error!")
                    return Building(floors: [])
                }
                
                first.connectTo(node: second, edgeLength: structure.length,
                                firstEdgeWeight: structure.firstWeight, secondEdgeWeight: structure.secondWeight)
            }
            let floor1 = Floor(number: 1, nodes: nodes.filter { $0.floor == 1 })
            let floor2 = Floor(number: 2, nodes: nodes.filter { $0.floor == 2 })
            let floor3 = Floor(number: 3, nodes: nodes.filter { $0.floor == 3 })
            return Building(floors: [floor1, floor2, floor3])
        } catch {
            print("Error \(error). Couldn't create building")
        }
        return Building(floors: [])
    }
    
    func dijkstraAlgorithm(from source: Node, to destination: Node) -> Path? {
        var visitedNodes: Set<Node> = []
        var frontier: [Path] = [] {
            didSet {
                frontier.sort { return $0.totalLength * $0.totalWeight < $1.totalLength * $1.totalWeight }
                // the frontier has to be always ordered
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
    
    func findPath(in building: [Node], from sourceNodeName: String, to destinationNodeName: String) throws -> [Node] {
        let sourceNode = building.filter( { $0.name == sourceNodeName }).first
        let destinationNode = building.filter( { $0.name == destinationNodeName }).first
        guard let source = sourceNode else {
            throw NavETUError.noSourceNode
        }
        guard let destination = destinationNode else {
        throw NavETUError.noDestinationNode
        }
        
        if let path = dijkstraAlgorithm(from: source, to: destination) {
            let pathNodeNamesArray: [String] = path.nodes.reversed().compactMap({$0}).map({$0.name})
            let resultString = pathNodeNamesArray.reduce("") { $0 + " ➝ " + $1 }
            print("Path: \(resultString), length = \(path.totalLength)")
            return path.nodes.reversed()
        } else {
            throw NavETUError.noPathFound
        }
    }
}
