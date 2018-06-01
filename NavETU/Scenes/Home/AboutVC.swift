//
//  AboutVC.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 31.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class AboutVC: UIViewController, Routable {
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var infoTextView: UITextView!
    @IBOutlet var botomLabel: UILabel!
    
    let storyboardName = "Main"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Информация"
        infoTextView.text = "Основан в 2018 году по проекту изобретательного студента СПбГЭТУ ''ЛЭТИ''.\nБизнес-центр используется исключительно для демонстрации работы системы 3D-навигации.\nНазвание бизнес-центра, названия компаний-арендаторов, планы здания, а также его расположение вымышлены.\n\nЛюбые совпадения случайны."
    }
}
