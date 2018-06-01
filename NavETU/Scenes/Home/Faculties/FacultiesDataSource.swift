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
        self.items.append(FacultiesCellModel(title: "ООО ''Тюльпан''", subtitle: "помещения 114-115"))
        self.items.append(FacultiesCellModel(title: "ЗАО ''Black Swan''", subtitle: "помещения 101, 107-108"))
        self.items.append(FacultiesCellModel(title: "ОАО ''АэроПлот''", subtitle: "помещение 111-112"))
        self.items.append(FacultiesCellModel(title: "ООО ''ПалеX''", subtitle: "помещения 202-204"))
        self.items.append(FacultiesCellModel(title: "ПАО ''Строитель''", subtitle: "помещения 206-208"))
        self.items.append(FacultiesCellModel(title: "ЗАО ''Параболитик''", subtitle: "помещение 211-213"))
        self.items.append(FacultiesCellModel(title: "ИП Гусёнкин И.В.", subtitle: "помещения 214-215"))
        self.items.append(FacultiesCellModel(title: "ИП Отличникова А.Я.", subtitle: "помещение 311-312"))
        self.items.append(FacultiesCellModel(title: "ОАО ''ГидроНакал''", subtitle: "помещение 315-317"))
        self.items.append(FacultiesCellModel(title: "ООО ''Тигрелла''", subtitle: "помещение 301-306, 318"))
    }
    
    subscript(indexPath: IndexPath) -> FacultiesCellModel {
        let model = items[indexPath.row]
        return model
    }
}
