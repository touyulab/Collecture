//
// TimeTableViewController.swift
//  Collecture
//
//  Created by Yuto Akiba on 2016/04/28.
//  Copyright © 2016年 Yuto Akiba. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {

    @IBOutlet weak var timeTableCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timeTableCollectionView.delegate = self
        timeTableCollectionView.dataSource = self
        
        timeTableCollectionView.registerNib(UINib(nibName: String(FirstRowCell), bundle: nil), forCellWithReuseIdentifier: String(FirstRowCell))
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension TimeTableViewController {
    func firstRowText(number: Int) -> String {
        switch number {
        case 1:
            return "Mon"
        case 2:
            return "Tue"
        case 3:
            return "Wed"
        case 4:
            return "Thu"
        case 5:
            return "Fri"
        case 6:
            return "Sat"
        default:
            return ""
        }
    }
    
    func setOverlayView(originFrame: CGRect) {
        
        timeTableCollectionView.userInteractionEnabled = false
        let y = originFrame.origin.y + DeviseSize.navBarHeight(self.navigationController!) + DeviseSize.statusBarHeight() - timeTableCollectionView.contentOffset.y
        let overlayView = OverlayView(frame: CGRect(origin: CGPointMake(originFrame.origin.x, y), size: originFrame.size))
        overlayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapedOverlayView(_:)))
        overlayView.addGestureRecognizer(tapRecognizer)
//        UIView.animateWithDuration(0.4, animations: {
//                overlayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
//                overlayView.frame = DeviseSize.bounds()
//                self.setUpButton(overlayView)
//            }, completion: { finished in
//        })
        
        UIView.animateWithDuration(0.8, // アニメーションの時間
            delay: 0,  // アニメーションの遅延時間
            usingSpringWithDamping: 1, // スプリングの効果(0..1)
            initialSpringVelocity: 0,  // バネの初速。(0..1)
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {() -> Void  in
                // アニメーションする処理
                overlayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
                overlayView.frame = DeviseSize.bounds()
                self.setUpMenu(overlayView)
            },
            completion: {(finished: Bool) -> Void in
                
        })
        
        self.navigationController?.view.addSubview(overlayView)
    }
    
    func tapedOverlayView(gestureRecognizer: UITapGestureRecognizer) {
        if let subViews = gestureRecognizer.view?.subviews {
            for subView in subViews {
                subView.alpha = 0
            }
        }
        UIView.animateWithDuration(0.4, animations: {
            if let overlayView = gestureRecognizer.view as? OverlayView {
                gestureRecognizer.view?.frame = overlayView.originFrame
            }
            gestureRecognizer.view?.alpha = 0
            }, completion: { finished in
                gestureRecognizer.view?.removeFromSuperview()
        })
        self.timeTableCollectionView.userInteractionEnabled = true
    }
    
    func setUpMenu(overlayView: UIView) {
        // let pictureView = UIView(frame: CGRect(origin: CGPointMake(overlayView.frame.size.width/2, overlayView.frame.size.height/4), size: CGSizeMake(85, 85)))
        let pictureView = UIView(frame: CGRect(origin: CGPointZero, size: CGSizeMake(85, 85)))
        pictureView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4)
        pictureView.backgroundColor = UIColor.whiteColor()
        pictureView.alpha = 0
        pictureView.layer.masksToBounds = true
        pictureView.layer.cornerRadius = 85/2
        
        let voiceView = UIView(frame: CGRect(origin: CGPointZero, size: CGSizeMake(85, 85)))
        voiceView.center = CGPointMake(self.view.frame.size.width/4, self.view.frame.size.height/2)
        voiceView.backgroundColor = UIColor.whiteColor()
        voiceView.alpha = 0
        voiceView.layer.masksToBounds = true
        voiceView.layer.cornerRadius = 85/2
        
        let memoView = UIView(frame: CGRect(origin: CGPointZero, size: CGSizeMake(85, 85)))
        memoView.center = CGPointMake(self.view.frame.size.width*3/4, self.view.frame.size.height/2)
        memoView.backgroundColor = UIColor.whiteColor()
        memoView.alpha = 0
        memoView.layer.masksToBounds = true
        memoView.layer.cornerRadius = 85/2
        
        let pictureLabel = UILabel()
        pictureLabel.text = "写真を見る"
        pictureLabel.textColor = UIColor.whiteColor()
        pictureLabel.font = UIFont.systemFontOfSize(12)
        pictureLabel.sizeToFit()
        pictureLabel.center = CGPoint(x: pictureView.center.x, y: pictureView.frame.origin.y+pictureView.frame.size.height+10)
        pictureLabel.alpha = 0
        
        let voiceLabel = UILabel()
        voiceLabel.text = "音声を聞く"
        voiceLabel.textColor = UIColor.whiteColor()
        voiceLabel.font = UIFont.systemFontOfSize(12)
        voiceLabel.sizeToFit()
        voiceLabel.center = CGPoint(x: voiceView.center.x, y: voiceView.frame.origin.y+voiceView.frame.size.height+10)
        voiceLabel.alpha = 0
        
        let memoLabel = UILabel()
        memoLabel.text = "メモを見る"
        memoLabel.textColor = UIColor.whiteColor()
        memoLabel.font = UIFont.systemFontOfSize(12)
        memoLabel.sizeToFit()
        memoLabel.center = CGPoint(x: memoView.center.x, y: memoView.frame.origin.y+memoView.frame.size.height+10)
        memoLabel.alpha = 0
        
        
        UIView.animateWithDuration(0.8, animations: {
            pictureView.alpha = 1
            voiceView.alpha = 1
            memoView.alpha = 1
            pictureLabel.alpha = 1
            voiceLabel.alpha = 1
            memoLabel.alpha = 1
            }, completion: { finished in
                
        })
        
        overlayView.addSubview(pictureView)
        overlayView.addSubview(voiceView)
        overlayView.addSubview(memoView)
        overlayView.addSubview(pictureLabel)
        overlayView.addSubview(voiceLabel)
        overlayView.addSubview(memoLabel)
    }
}

extension TimeTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let firstRowCellColor = UIColor.wetAsphalt()
        let firstColumnCellColor = UIColor.wetAsphalt()
        
        // dequeueReusableCellWithReuseIdentifier の働きは
        // 再利用できるセルがあればそれを使う
        // 再利用できるセルがなければ生成する
        // Cell はストーリーボードで設定したセルのID
        let cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)

        guard let firstRowCell: FirstRowCell = collectionView.dequeueReusableCellWithReuseIdentifier(String(FirstRowCell), forIndexPath: indexPath) as? FirstRowCell else { return cell }

        
        if indexPath.row >= 1 && indexPath.row < 6 {
            //cell.backgroundColor = firstRowCellColor
            firstRowCell.backgroundColor = firstRowCellColor
            firstRowCell.setUpCell(firstRowText(indexPath.row))
            return firstRowCell
            
        } else if indexPath.row % 6 == 0 {
            if indexPath.row == 0 {
                cell.backgroundColor = UIColor.whiteColor()
            } else {
                cell.backgroundColor = firstColumnCellColor
                
            }
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
    
        return cell
    }
    
    //section 数の設定、今回は１つにセット
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return 48;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        print(self.view.frame.width)
        print((self.view.frame.width-20-5)/5)
        print(collectionView.frame.width)
        
        if indexPath.row >= 1 && indexPath.row < 6 {
            return CGSize(width: (collectionView.frame.width-30-5.1)/5, height: 30)
        } else if indexPath.row % 6 == 0 {
            if indexPath.row == 0 {
                return CGSize(width: 30, height: 30)
            } else {
                return CGSize(width: 30, height: 100)
            }
        } else {
            return CGSize(width: (collectionView.frame.width-30-5.1)/5, height: 100)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("didSelect: \(indexPath.row)")
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            // print(collectionView.contentOffset)
            setOverlayView(cell.frame)
        }
    }
    
}
