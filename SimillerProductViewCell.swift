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
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var getQuoteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell()  {
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
