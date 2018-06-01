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
 
    func createData() {
        self.items.append(HomeCellModel(title: "О бизнес-центре"))
        self.items.append(HomeCellModel(title: "Компании-арендаторы"))
        self.items.append(HomeCellModel(title: "Кафетерий"))
        self.items.append(HomeCellModel(title: "Здравпункт"))
        self.items.append(HomeCellModel(title: "Библиотека"))
        self.items.append(HomeCellModel(title: "Туалеты"))
    }
    
    subscript(indexPath: IndexPath) -> HomeCellModel {
        let model = items[indexPath.row]
        return model
    }
}

