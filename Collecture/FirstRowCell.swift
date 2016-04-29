//
//  FirstRowCell.swift
//  Collecture
//
//  Created by Yuto Akiba on 2016/04/28.
//  Copyright © 2016年 Yuto Akiba. All rights reserved.
//

import UIKit

class FirstRowCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(text: String) {
        label.text = text
        label.sizeToFit()
    }
}
