//
//  Floor.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 13.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class Floor {
    let number: Int
    let edges: [Edge]
    
    init(number: Int, edges: [Edge]) {
        self.number = number
        self.edges = edges
    }
}
