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
    
    func presentItem(controller: UINavigationController, item: HomeCellModel, for key: Int) {
        var vc = UIViewController()
        switch key {
        case 0:
            vc = FacultiesVC.instantiate()
//          vc = AboutVC.instantiate()
        case 1:
            vc = FacultiesVC.instantiate()
        case 2:
            vc = FacultiesVC.instantiate()
//          vc = DepartmentsVC.instantiate()
        case 3:
            vc = FacultiesVC.instantiate()
//          vc = HealthUnitVC.instantiate()
        case 4:
            vc = FacultiesVC.instantiate()
//          vc = LibrariesVC.instantiate()
        case 5:
            vc = FacultiesVC.instantiate()
//          vc = FoodVC.instantiate()
        case 6:
            vc = FacultiesVC.instantiate()
//          vc = WaterClosetsVC.instantiate()
        default:
            vc = ViewController.instantiate()
        }
        controller.pushViewController(vc, animated: true)
        
    }
    
    func presentFaculty(controller: UINavigationController, faculty: FacultiesCellModel, for key: Int) {
        
    }
    
}
