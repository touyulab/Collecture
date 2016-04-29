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
        
        let menuButton = MenuButton(frame: CGRect(origin: CGPointZero, size: CGSize(width: 70, height: 70)))
        menuButton.center = CGPoint(x: self.view.frame.size.width-50, y: self.view.frame.size.height-50)
        menuButton.backgroundColor = UIColor.wetAsphalt()
        menuButton.layer.masksToBounds = true
        menuButton.layer.cornerRadius = 35
        menuButton.addTarget(self, action: #selector(tapedMenuButton(_:)), forControlEvents: .TouchUpInside)
        menuButton.setUpMenuButtons(self.navigationController!.view)
        self.navigationController?.view.addSubview(menuButton)
    
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
        
        UIView.animateWithDuration(0.8, // アニメーションの時間
            delay: 0,  // アニメーションの遅延時間
            usingSpringWithDamping: 1, // スプリングの効果(0..1)
            initialSpringVelocity: 0,  // バネの初速。(0..1)
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {() -> Void  in
                // アニメーションする処理
                overlayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
                overlayView.frame = DeviseSize.bounds()
                // self.setUpMenu(overlayView)
            },
            completion: {(finished: Bool) -> Void in
                
        })
        
        self.navigationController?.view.addSubview(overlayView)
    }
    
    func tapedOverlayView(gestureRecognizer: UITapGestureRecognizer) {
        
        let tapCGPoint = gestureRecognizer.locationOfTouch(0, inView: gestureRecognizer.view)
        let pointXY = (tapCGPoint.x, tapCGPoint.y)
        print(tapCGPoint)
        print((gestureRecognizer.view as? OverlayView)?.pictureView.center)
        guard let overlayView = gestureRecognizer.view as? OverlayView else { return }
        
        let pictureXRange: ClosedInterval<CGFloat> = overlayView.pictureView.frame.origin.x...overlayView.pictureView.frame.origin.x+overlayView.pictureView.frame.size.width
        let pictureYRange: ClosedInterval<CGFloat> = overlayView.pictureView.frame.origin.y...overlayView.pictureView.frame.origin.y+overlayView.pictureView.frame.size.width

        switch pointXY {
        case (pictureXRange, pictureYRange):
            print("pictureViewRange")
        default:
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
    }
    
    func tapedMenuButton(sender: UIButton) {
        if sender.backgroundColor == UIColor.wetAsphalt() {
            UIView.animateWithDuration(0.4, animations: {
                sender.backgroundColor = UIColor.carrot()
                if let menuButton = sender as? MenuButton {
                    menuButton.tapedAnimation()
                }
            })
        } else {
            UIView.animateWithDuration(0.4, animations: {
                sender.backgroundColor = UIColor.wetAsphalt()
                if let menuButton = sender as? MenuButton {
                    menuButton.cancelAnimetion()
                }
            })
        }
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
