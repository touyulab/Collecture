//
//  OverlayView.swift
//  Collecture
//
//  Created by Yuto Akiba on 2016/04/29.
//  Copyright © 2016年 Yuto Akiba. All rights reserved.
//

import UIKit

class OverlayView: UIView {
    
    var originFrame: CGRect = CGRectZero
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        originFrame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
