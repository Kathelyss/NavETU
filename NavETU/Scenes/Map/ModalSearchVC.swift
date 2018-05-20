//
//  ModalSearchVC.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 20.05.2018.
//  Copyright © 2018 Екатерина Рыжова. All rights reserved.
//

import UIKit

class ModalSearchVC: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var toTextField: UITextField!
    @IBOutlet var showButton: UIButton!
    @IBAction func tapShowButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
