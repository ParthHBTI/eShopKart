//
//  AddressViewCell.swift
//  BrillCreation
//
//  Created by mac on 15/07/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class AddressViewCell: UITableViewCell {
    
    var flag: Bool = false
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var addressTextField: UITextView!
    @IBOutlet weak var selectionBtn: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func selectionAct(sender: AnyObject) {
        let tempCell = UITableView()
        if flag != false {
            self.editButton.hidden = true
            self.deleteButton.hidden = true
            self.selectionBtn.tintColor = UIColor.blackColor()
            flag = false
            
            } else {
            self.editButton.hidden = false
            self.deleteButton.hidden = false
            self.selectionBtn.tintColor = UIColor.blueColor()
            flag = true
        }
    }
 
   override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
