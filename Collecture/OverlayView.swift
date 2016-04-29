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
    
    let pictureView = UIImageView(frame: CGRect(origin: CGPointZero, size: CGSizeMake(85, 85)))
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        originFrame = frame
        setUpMenu(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpMenu(overlayView: UIView) {
        // let pictureView = UIView(frame: CGRect(origin: CGPointMake(overlayView.frame.size.width/2, overlayView.frame.size.height/4), size: CGSizeMake(85, 85)))
        pictureView.center = originFrame.origin
        pictureView.image = UIImage(named: "picture_pink")
        pictureView.alpha = 0
        pictureView.layer.masksToBounds = true
        pictureView.layer.cornerRadius = 85/2
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapedPictureView(_:)))
//        pictureView.addGestureRecognizer(tapRecognizer)
        
        let voiceView = UIImageView(frame: CGRect(origin: CGPointZero, size: CGSizeMake(85, 85)))
        voiceView.center = originFrame.origin
        voiceView.image = UIImage(named: "headphone_lightYellow")
        voiceView.alpha = 0
        voiceView.layer.masksToBounds = true
        voiceView.layer.cornerRadius = 85/2
        
        let memoView = UIImageView(frame: CGRect(origin: CGPointZero, size: CGSizeMake(85, 85)))
        memoView.center = originFrame.origin
        memoView.image = UIImage(named: "memo_lightBlue")
        memoView.alpha = 0
        memoView.layer.masksToBounds = true
        memoView.layer.cornerRadius = 85/2
        
        let pictureLabel = UILabel()
        pictureLabel.text = "写真を見る"
        pictureLabel.textColor = UIColor.whiteColor()
        pictureLabel.font = UIFont.systemFontOfSize(12)
        pictureLabel.sizeToFit()
        pictureLabel.center = originFrame.origin
        pictureLabel.alpha = 0
        
        let voiceLabel = UILabel()
        voiceLabel.text = "音声を聞く"
        voiceLabel.textColor = UIColor.whiteColor()
        voiceLabel.font = UIFont.systemFontOfSize(12)
        voiceLabel.sizeToFit()
        voiceLabel.center = originFrame.origin
        voiceLabel.alpha = 0
        
        let memoLabel = UILabel()
        memoLabel.text = "メモを見る"
        memoLabel.textColor = UIColor.whiteColor()
        memoLabel.font = UIFont.systemFontOfSize(12)
        memoLabel.sizeToFit()
        memoLabel.center = originFrame.origin
        memoLabel.alpha = 0
        
        overlayView.addSubview(pictureView)
        overlayView.addSubview(voiceView)
        overlayView.addSubview(memoView)
        overlayView.addSubview(pictureLabel)
        overlayView.addSubview(voiceLabel)
        overlayView.addSubview(memoLabel)
        
        
        UIView.animateWithDuration(0.6, animations: {
            self.pictureView.alpha = 1
            voiceView.alpha = 1
            memoView.alpha = 1
            pictureLabel.alpha = 1
            voiceLabel.alpha = 1
            memoLabel.alpha = 1
            self.pictureView.center = CGPointMake(CGFloat(DeviseSize.screenWidth())/2, CGFloat(DeviseSize.screenHeight())/4)
            voiceView.center = CGPointMake(CGFloat(DeviseSize.screenWidth())/4, CGFloat(DeviseSize.screenHeight())/2)
            memoView.center = CGPointMake(CGFloat(DeviseSize.screenWidth())*3/4, CGFloat(DeviseSize.screenHeight())/2)
            pictureLabel.center = CGPoint(x: self.pictureView.center.x, y: self.pictureView.frame.origin.y+self.pictureView.frame.size.height+10)
            voiceLabel.center = CGPoint(x: voiceView.center.x, y: voiceView.frame.origin.y+voiceView.frame.size.height+10)
            memoLabel.center = CGPoint(x: memoView.center.x, y: memoView.frame.origin.y+memoView.frame.size.height+10)
            }, completion: { finished in
                
        })
    }
    
}

extension OverlayView {
    func tapedPictureView(gestureRecognizer: UITapGestureRecognizer) {
        print("aaaaaaaa")
    }
}

