//
//  myOrdersCell.swift
//  BrillCreation
//
//  Created by mac on 27/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class myOrdersCell: UITableViewCell {

    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productStatus: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productStatusDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
