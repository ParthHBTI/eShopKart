//
//  UserProfileCell.swift
//  eShopKart
//
//  Created by Apple on 29/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {

    @IBOutlet var imageIcon: UIImageView!
    @IBOutlet var profileLbl: UILabel!
    @IBOutlet var moreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
