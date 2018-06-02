//
//  AdditionVC.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 01.06.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

enum AdditionType {
    case cafe
    case library
    case healthUnit
}

class AdditionVC: UIViewController, Routable {
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var infoTextView: UITextView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!

    let storyboardName = "Main"
    
    var additionType: AdditionType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if additionType == .cafe {
            navigationItem.title = "Кафетерий"
            backgroundImageView.image = #imageLiteral(resourceName: "cafe")
            headerLabel.text = "Кафе ''Редукция''"
            infoTextView.text =
            "Необычная кухня, внимательный персонал и приятная атмосфера - всё это Мы!\n\nОткрыты для Вас с 10:00 до 19:00"
            bottomLabel.text = "1 этаж, помещение 106"
        } else if additionType == .library {
            navigationItem.title = "Библиотека"
            backgroundImageView.image = #imageLiteral(resourceName: "library")
            headerLabel.text = "Пожалуй, лучшее место для отдыха!"
            infoTextView.text = "\nРежим работы:\nс 09:00 до 17:00\n"
            bottomLabel.text = "2 этаж, помещения 201-202"
        } else if additionType == .healthUnit {
            navigationItem.title = "Медпункт"
            backgroundImageView.image = #imageLiteral(resourceName: "health")
            headerLabel.text = "Наша работа - забота о Вашем здоровье!"
            infoTextView.text =
            "\nМедпункт работает круглосуточно\n"
            bottomLabel.text = "1 этаж, помещение 102"
        }
    }
}
