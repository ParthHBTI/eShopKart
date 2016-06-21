//
//  ItemDetailViewCell.swift
//  eShopKart
//
//  Created by Apple on 23/02/1938 Saka.
//  Copyright © 1938 Saka Kloudrac. All rights reserved.
//

import UIKit

class ItemDetailViewCell: UITableViewCell,UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var desTextView: UITextView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var ImgControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

