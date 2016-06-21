//
//  cartItemCell.swift
//  eShopKart
//
//  Created by Apple on 09/03/1938 Saka.
//  Copyright © 1938 Saka kloudRac.com. All rights reserved.
//

import UIKit

class cartItemCell: UITableViewCell {

    @IBOutlet weak var removBtn: UIButton!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productColor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
