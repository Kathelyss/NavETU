//
//  Router.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 17.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import Foundation
import UIKit

class Router {
    func presentViewController(controller: UINavigationController) {
        let vc = ViewController.instantiate()
        controller.pushViewController(vc, animated: true)
    }
}
