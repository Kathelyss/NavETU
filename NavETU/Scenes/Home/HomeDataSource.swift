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
        self.items.append(HomeCellModel(title: "О ЛЭТИ"))
        self.items.append(HomeCellModel(title: "Факультеты"))
        self.items.append(HomeCellModel(title: "Кафедры"))
        self.items.append(HomeCellModel(title: "Здравпункт"))
        self.items.append(HomeCellModel(title: "Библиотеки"))
        self.items.append(HomeCellModel(title: "Столовые, буфеты, кафе"))
        self.items.append(HomeCellModel(title: "Туалеты"))
        self.items.append(HomeCellModel(title: "Другое"))
    }
    
    subscript(indexPath: IndexPath) -> HomeCellModel {
        let model = items[indexPath.row]
        return model
    }
}

