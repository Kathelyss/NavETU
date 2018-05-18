//
//  Drawing.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 17.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class Drawing {
    let graph: Building
    
    init(graph: Building) {
        self.graph = graph
    }

    func createTestGraph() -> Building {
        let nodes = createNodes()
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
        
        return Building(floors: [Floor(number: 1, edges: edges1), Floor(number: 2, edges: edges2)])
    }
}
