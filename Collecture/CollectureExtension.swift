//
//  CollectureExtension.swift
//  Collecture
//
//  Created by Yuto Akiba on 2016/04/28.
//  Copyright © 2016年 Yuto Akiba. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func turquoise() -> UIColor {
        return hexColor(0x1abc9c)
    }
    
    class func emerald() -> UIColor {
        return hexColor(0x2ecc71)
    }


    class func peterRiver() -> UIColor {
        return hexColor(0x3498db)
    }

    class func amethyst() -> UIColor {
        return hexColor(0x9b59b6)
    }

    class func wetAsphalt() -> UIColor {
        return hexColor(0x34495e)
    }

    class func sunFlower() -> UIColor {
        return hexColor(0xf1c40f)
    }

    class func carrot() -> UIColor {
        return hexColor(0xe67e22)
    }

    class func alizarin() -> UIColor {
        return hexColor(0xe74c3c)
    }

    class func flatPink() -> UIColor {
        return hexColor(0xE67168)
    }
}

// 16進表記のカラーコードでUIColorを指定します
// パラメータ
//  hex: 16進表記のカラーコード(書式:0xFFFF)
//  alpha: 透明度
//
func hexColor(hex: Int, alpha: Float = 1.0 ) -> UIColor {
    let r = Float((hex >> 16) & 0xFF) / 255.0
    let g = Float((hex >> 8) & 0xFF) / 255.0
    let b = Float((hex) & 0xFF) / 255.0
    return UIColor(red: CGFloat(r), green: CGFloat(g),
                   blue: CGFloat(b), alpha: CGFloat(alpha))
}
