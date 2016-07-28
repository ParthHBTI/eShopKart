//
//  MyOrderNumberCell.swift
//  BrillCreation
//
//  Created by mac on 27/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class MyOrderNumberCell: UITableViewCell {

    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var totalOrderedItems: UILabel?
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
