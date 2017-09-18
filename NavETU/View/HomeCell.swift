//
//  HomeCell.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 18.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell/*, XIBInitableCell*/ {
    @IBOutlet var container: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var forwardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.text = "test"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
