//
//  Router.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 17.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import Foundation
import UIKit

/**
 To push new controller use 'present' methods
 To present controller modally use 'show' methods
 To switch between tabs use 'switch' methods
 */

class Router {
    func presentViewController(controller: UINavigationController) {
        let vc = ViewController.instantiate()
        controller.pushViewController(vc, animated: true)
    }
    
    func presentFacultiesVC(controller: UINavigationController, item: HomeCellModel) {
        let vc = FacultiesVC.instantiate()
        controller.pushViewController(vc, animated: true)
    }
    
}
