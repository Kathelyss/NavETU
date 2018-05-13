//
//  HomeCellBuilder.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 18.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import Foundation
import UIKit

struct HomeCellBuilder {
    static func populate(cell: UICollectionViewCell, with model: HomeCellModel) {
        if let cell = cell as? HomeCell {
            cell.titleLabel.text = model.title
        }
    }
}
