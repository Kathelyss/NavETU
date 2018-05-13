//
//  HomeDataSource.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 18.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import Foundation

class HomeDataSource {
    var items: [HomeCellModel] = []
    var count: Int { return items.count }
 
    func createFakeData() {
        self.items.append(HomeCellModel(title: "Home.aboutLETI".localized))
        self.items.append(HomeCellModel(title: "Home.faculties".localized))
        self.items.append(HomeCellModel(title: "Home.departments".localized))
        self.items.append(HomeCellModel(title: "Home.healthUnit".localized))
        self.items.append(HomeCellModel(title: "Home.libraries".localized))
        self.items.append(HomeCellModel(title: "Home.food".localized))
        self.items.append(HomeCellModel(title: "Home.wc".localized))
        self.items.append(HomeCellModel(title: "Home.other".localized))
    }
    
    subscript(indexPath: IndexPath) -> HomeCellModel {
        let model = items[indexPath.row]
        return model
    }
}

