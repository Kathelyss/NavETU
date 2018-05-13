//
//  FacultiesDataSource.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 29.04.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import Foundation

class FacultiesDataSource {
    var items: [FacultiesCellModel] = []
    var count: Int { return items.count }
    
    func createFakeData() {
        self.items.append(FacultiesCellModel(title: "Home.FacultiesVC.FKTI".localized))
        self.items.append(FacultiesCellModel(title: "Home.FacultiesVC.FRT".localized))
        self.items.append(FacultiesCellModel(title: "Home.FacultiesVC.FEL".localized))
        self.items.append(FacultiesCellModel(title: "Home.FacultiesVC.FEA".localized))
        self.items.append(FacultiesCellModel(title: "Home.FacultiesVC.FIBS".localized))
        self.items.append(FacultiesCellModel(title: "Home.FacultiesVC.FEM".localized))
        self.items.append(FacultiesCellModel(title: "Home.FacultiesVC.GF".localized))
        self.items.append(FacultiesCellModel(title: "Home.FacultiesVC.OF".localized))
        self.items.append(FacultiesCellModel(title: "Home.FacultiesVC.FFIO".localized))
    }
    
    subscript(indexPath: IndexPath) -> FacultiesCellModel {
        let model = items[indexPath.row]
        return model
    }
}
