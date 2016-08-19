//
//  ProductDetailCell.swift
//  CategoryViewController
//
//  Created by mac on 01/08/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class ProductDetailCell: UITableViewCell {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var pageViewCon: UIPageControl!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var productMat: UILabel!
    @IBOutlet weak var productQty: UITextField!
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var productWebView: UIWebView!
    @IBOutlet weak var size: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
