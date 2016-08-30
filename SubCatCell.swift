//
//  SubCatCell.swift
//  BrillCreation
//
//  Created by mac on 23/08/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class SubCatCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let destinationVC = segue.destinationViewController as! CategoryItemListVC
//        let cell = sender as! ESKCategoryCell
//        destinationVC.categoryName = cell.TextLabel!.text
//        destinationVC.categoryId = cell.cellId!.text
//        destinationVC.DataSend = dataSend
//        
    }

}
