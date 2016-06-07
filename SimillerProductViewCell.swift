//
//  SimillerProductViewCell.swift
//  eShopKart
//
//  Created by mac on 20/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class SimillerProductViewCell: UITableViewCell {
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var productnameLbl: UILabel!
    @IBOutlet weak  var rsLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
