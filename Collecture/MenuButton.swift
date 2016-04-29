//
//  MenuButton.swift
//  Collecture
//
//  Created by Yuto Akiba on 2016/04/29.
//  Copyright © 2016年 Yuto Akiba. All rights reserved.
//

import UIKit

class MenuButton: UIButton {
    
    let firstBar = UIView()
    let secondBar = UIView()
    let thirdBar = UIView()
    
    let cameraButton = UIButton()
    let voiceButton = UIButton()
    let memoButton = UIButton()
    
    var flag = 0
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setUpMenuButtonIcon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpMenuButtonIcon() {
        firstBar.frame.size = CGSize(width: self.frame.size.width/2, height: 4)
        firstBar.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*3/8)
        firstBar.backgroundColor = UIColor.whiteColor()
        firstBar.userInteractionEnabled = false
        secondBar.frame.size = CGSize(width: self.frame.size.width/2, height: 4)
        secondBar.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*4/8)
        secondBar.backgroundColor = UIColor.whiteColor()
        secondBar.userInteractionEnabled = false
        thirdBar.frame.size = CGSize(width: self.frame.size.width/2, height: 4)
        thirdBar.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*5/8)
        thirdBar.backgroundColor = UIColor.whiteColor()
        thirdBar.userInteractionEnabled = false
        
        self.addSubview(firstBar)
        self.addSubview(secondBar)
        self.addSubview(thirdBar)
    }
    
    func tapedAnimation() {
        
        UIView.animateWithDuration(0.8, animations: {
            let angle:CGFloat = CGFloat((45.0 * M_PI) / 180.0)
            let minusAngle:CGFloat = CGFloat((-45.0 * M_PI) / 180.0)
            self.firstBar.transform = CGAffineTransformMakeRotation(angle)
            self.thirdBar.transform = CGAffineTransformMakeRotation(minusAngle)
            self.firstBar.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            self.thirdBar.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            self.secondBar.alpha = 0
            
        })
        
        UIView.animateWithDuration(1, // アニメーションの時間
            delay: 0,  // アニメーションの遅延時間
            usingSpringWithDamping: 0.4, // スプリングの効果(0..1)
            initialSpringVelocity: 0.4,  // バネの初速。(0..1)
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {() -> Void  in
                // アニメーションする処理
                // 縦方向アニメーション
                if self.flag == 0 {
                self.cameraButton.center = CGPoint(x: self.center.x, y: self.center.y-self.frame.size.height-20)
                self.voiceButton.center = CGPoint(x: self.center.x, y: self.center.y-self.frame.size.height-self.cameraButton.frame.size.height-20*2)
                self.memoButton.center = CGPoint(x: self.center.x, y: self.center.y-self.frame.size.height-self.cameraButton.frame.size.height-self.voiceButton.frame.size.height-20*3)
                }
                else {
                // 横方向アニメーション
                self.cameraButton.center = CGPoint(x: self.center.x, y: self.center.y-self.frame.size.height-20)
                self.voiceButton.center = CGPoint(x: self.center.x-self.frame.size.width-20, y: self.center.y)
                self.memoButton.center = CGPoint(x: self.center.x-self.frame.size.width-20, y: self.center.y-self.frame.size.height-20)
                }
                self.cameraButton.alpha = 1
                self.voiceButton.alpha = 1
                self.memoButton.alpha = 1
                self.flag += 1
            },
            completion: {(finished: Bool) -> Void in
                
        })
    }
    
    func cancelAnimetion() {

        UIView.animateWithDuration(0.8, animations: {
            self.firstBar.transform = CGAffineTransformMakeRotation(0)
            self.thirdBar.transform = CGAffineTransformMakeRotation(0)
            self.firstBar.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*3/8)
            self.thirdBar.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height*5/8)
            self.secondBar.alpha = 1
            
            self.cameraButton.center = self.center
            self.voiceButton.center = self.center
            self.memoButton.center = self.center
            self.cameraButton.alpha = 0
            self.voiceButton.alpha = 0
            self.memoButton.alpha = 0
        })
    }
    
    func setUpMenuButtons(parentView: UIView) {
        cameraButton.frame.size = CGSize(width: self.frame.size.width-10, height: self.frame.size.height-10)
        cameraButton.center = self.center
        cameraButton.setImage(UIImage(named: "camera_pink"), forState: .Normal)
        cameraButton.layer.masksToBounds = true
        cameraButton.layer.cornerRadius = (self.frame.size.width-10)/2
        cameraButton.alpha = 0
        parentView.addSubview(cameraButton)
        
        voiceButton.frame.size = CGSize(width: self.frame.size.width-10, height: self.frame.size.height-10)
        voiceButton.center = self.center
        voiceButton.setImage(UIImage(named: "voice_lightYellow"), forState: .Normal)
        voiceButton.layer.masksToBounds = true
        voiceButton.layer.cornerRadius = (self.frame.size.width-10)/2
        voiceButton.alpha = 0
        parentView.addSubview(voiceButton)
        
        memoButton.frame.size = CGSize(width: self.frame.size.width-10, height: self.frame.size.height-10)
        memoButton.center = self.center
        memoButton.setImage(UIImage(named: "pen_lightBlue"), forState: .Normal)
        memoButton.layer.masksToBounds = true
        memoButton.layer.cornerRadius = (self.frame.size.width-10)/2
        memoButton.alpha = 0
        parentView.addSubview(memoButton)
        
        parentView.bringSubviewToFront(self)
    }
}
