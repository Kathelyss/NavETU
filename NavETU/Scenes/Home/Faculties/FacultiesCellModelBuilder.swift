//
//  FacultiesCellModelBuilder.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 29.04.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation
import UIKit

struct FacultiesCellModel  {
    let title: String!
    let subtitle: String!
}

struct FacultiesCellBuilder {
    static func populate(cell: UICollectionViewCell, with model: FacultiesCellModel) {
        if let cell = cell as? FacultyCell {
            cell.titleLabel.text = model.title
            cell.subTitleLabel.text = model.subtitle
        }
    }
    
}
