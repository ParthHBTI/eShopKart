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
        let buttonPress = sender.tag
        print(buttonPress)
        let tempCell =  AddressViewCell()
        for  temp in 0...buttonPress {
            if temp  == buttonPress {
                tempCell.deleteButton?.hidden = false
                tempCell.editButton?.hidden = false
            } else {
                tempCell.deleteButton?.hidden = true
                tempCell.editButton?.hidden = true
            }
        }
    }
 
   override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
