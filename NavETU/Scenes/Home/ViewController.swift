//
//  ViewController.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 17.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Routable {
    let storyboardName = "Main"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Next VC".localized
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

