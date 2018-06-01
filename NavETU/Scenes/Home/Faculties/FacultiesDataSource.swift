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
        self.items.append(FacultiesCellModel(title: "ООО ''Тюльпан''", subtitle: "помещение 101"))
        self.items.append(FacultiesCellModel(title: "ЗАО ''Black Swan''", subtitle: "помещение 101"))
        self.items.append(FacultiesCellModel(title: "ОАО ''ЛенАэро''", subtitle: "помещение 101"))
        self.items.append(FacultiesCellModel(title: "ПАО ''Строитель''", subtitle: "помещение 101"))
        self.items.append(FacultiesCellModel(title: "ООО ''ПалеX''", subtitle: "помещение 101"))
        self.items.append(FacultiesCellModel(title: "ОАО ''Гдепломат''", subtitle: "помещение 101"))
        self.items.append(FacultiesCellModel(title: "ЗАО ''Парабола''", subtitle: "помещение 101"))
        self.items.append(FacultiesCellModel(title: "ИП Гусёнкин И.В.", subtitle: "помещение 101"))
        self.items.append(FacultiesCellModel(title: "ИП Отличникова А.Я.", subtitle: "помещение 101"))
    }
    
    subscript(indexPath: IndexPath) -> FacultiesCellModel {
        let model = items[indexPath.row]
        return model
    }
}
