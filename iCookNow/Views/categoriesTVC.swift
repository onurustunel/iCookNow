//
//  categoriesTVC.swift
//  iCookNow
//
//  Created by MEHMET ONUR ÜSTÜNEL on 16.06.2020.
//  Copyright © 2020 MEHMET ONUR ÜSTÜNEL. All rights reserved.
//  twitter.com/onur_ustunel
//

import UIKit

class categoriesTVC: UITableViewCell {

    
    @IBOutlet weak var categoriesImage: UIImageView!
    @IBOutlet weak var categoriesName: UILabel!
    @IBOutlet weak var categoriesDetail: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
