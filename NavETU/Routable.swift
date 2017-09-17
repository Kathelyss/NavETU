//
//  Routable.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 17.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import UIKit

protocol Routable: class {
    static var storyboardName: String { get }
    static var ibName: String { get }
    
    static func instantiate() -> UIViewController
}

extension Routable where Self: UIViewController {
    static var storyboardName: String { return "Main" }
    static var ibName: String { return String(describing: self) }
    
    static func instantiate() -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: ibName)
    }
}
