//
//  CameraViewController.swift
//  Collecture
//
//  Created by Yuto Akiba on 2016/04/30.
//  Copyright © 2016年 Yuto Akiba. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UIGestureRecognizerDelegate  {
    
    var input:AVCaptureDeviceInput!
    var output:AVCaptureVideoDataOutput!
    var session:AVCaptureSession!
    var camera:AVCaptureDevice!
    var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 画面タップでシャッターを切るための設定
//        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CameraViewController.tapped(_:)))
//        // デリゲートをセット
//        tapGesture.delegate = self;
//        // Viewに追加.
//        self.view.addGestureRecognizer(tapGesture)
        
        let underView = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: self.view.frame.size.width, height:self.view.frame.size.height/8)))
        underView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-underView.frame.size.height/2)
        underView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        self.view.addSubview(underView)
        
        let shutterButton = UIButton(frame: CGRect(origin: CGPointZero, size: CGSize(width: underView.frame.size.height-15, height: underView.frame.size.height-15)))
        shutterButton.center = CGPoint(x: underView.frame.size.width/2, y: underView.frame.size.height/2)
        shutterButton.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        shutterButton.layer.masksToBounds = true
        shutterButton.layer.cornerRadius = shutterButton.frame.size.width/2
        shutterButton.layer.borderColor = UIColor.whiteColor().CGColor
        shutterButton.layer.borderWidth = 6
        shutterButton.addTarget(self, action: #selector(tapedShutterButton(_:)), forControlEvents: .TouchUpInside)
        underView.addSubview(shutterButton)
        
        let shutterShadowView = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: shutterButton.frame.size.height-18, height: shutterButton.frame.size.height-18)))
        shutterShadowView.center = CGPoint(x: shutterButton.frame.size.width/2, y: shutterButton.frame.size.height/2)
        shutterShadowView.backgroundColor = UIColor.whiteColor()
        shutterShadowView.layer.masksToBounds = true
        shutterShadowView.layer.cornerRadius = shutterShadowView.frame.size.width/2
        // shutterShadowView.layer.borderColor = UIColor.blackColor().CGColor
        // shutterShadowView.layer.borderWidth = 3
        shutterShadowView.userInteractionEnabled = false
        shutterButton.addSubview(shutterShadowView)
        
        let closeButton = UIButton()
        closeButton.setTitle("閉じる", forState: .Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton.sizeToFit()
        closeButton.center = CGPoint(x: (underView.frame.size.width+shutterButton.center.x+shutterButton.frame.size.width/2)/2, y: underView.frame.size.height/2)
        closeButton.addTarget(self, action: #selector(tapedCloseButton(_:)), forControlEvents: .TouchUpInside)
        underView.addSubview(closeButton)
    }
    
    override func viewWillAppear(animated: Bool) {
        // スクリーン設定
        setupDisplay()
        // カメラの設定
        setupCamera()
    }
    
    // メモリ解放
    override func viewDidDisappear(animated: Bool) {
        // camera stop メモリ解放
        session.stopRunning()
        
        for output in session.outputs {
            session.removeOutput(output as? AVCaptureOutput)
        }
        
        for input in session.inputs {
            session.removeInput(input as? AVCaptureInput)
        }
        session = nil
        camera = nil
    }
    
    func setupDisplay(){
        //スクリーンの幅
        let screenWidth = UIScreen.mainScreen().bounds.size.width;
        //スクリーンの高さ
        let screenHeight = UIScreen.mainScreen().bounds.size.height;
        
        // プレビュー用のビューを生成
        imageView = UIImageView()
        imageView.frame = CGRectMake(0.0, 0.0, screenWidth, screenHeight)
    }
    
    func setupCamera(){
        // AVCaptureSession: キャプチャに関する入力と出力の管理
        session = AVCaptureSession()
        
        // sessionPreset: キャプチャ・クオリティの設定
        session.sessionPreset = AVCaptureSessionPresetHigh
        //        session.sessionPreset = AVCaptureSessionPresetPhoto
        //        session.sessionPreset = AVCaptureSessionPresetHigh
        //        session.sessionPreset = AVCaptureSessionPresetMedium
        //        session.sessionPreset = AVCaptureSessionPresetLow
        
        // AVCaptureDevice: カメラやマイクなどのデバイスを設定
        for caputureDevice: AnyObject in AVCaptureDevice.devices() {
            // 背面カメラを取得
            if caputureDevice.position == AVCaptureDevicePosition.Back {
                camera = caputureDevice as? AVCaptureDevice
            }
            // 前面カメラを取得
            //if caputureDevice.position == AVCaptureDevicePosition.Front {
            //    camera = caputureDevice as? AVCaptureDevice
            //}
        }
        
        // カメラからの入力データ
        // swift 2.0
        do {
            input = try AVCaptureDeviceInput(device: camera) as AVCaptureDeviceInput
        } catch let error as NSError {
            print(error)
        }
        
        
        // 入力をセッションに追加
        if(session.canAddInput(input)) {
            session.addInput(input)
        }
        
        
        // AVCaptureStillImageOutput:静止画
        // AVCaptureMovieFileOutput:動画ファイル
        // AVCaptureAudioFileOutput:音声ファイル
        // AVCaptureVideoDataOutput:動画フレームデータ
        // AVCaptureAudioDataOutput:音声データ
        
        // AVCaptureVideoDataOutput:動画フレームデータを出力に設定
        output = AVCaptureVideoDataOutput()
        // 出力をセッションに追加
        if(session.canAddOutput(output)) {
            session.addOutput(output)
        }
        
        // ピクセルフォーマットを 32bit BGR + A とする
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey : Int(kCVPixelFormatType_32BGRA)]
        
        // フレームをキャプチャするためのサブスレッド用のシリアルキューを用意
        output.setSampleBufferDelegate(self, queue: dispatch_get_main_queue())
        
        output.alwaysDiscardsLateVideoFrames = true
        
        // ビデオ出力に接続
        //        let connection = output.connectionWithMediaType(AVMediaTypeVideo)
        
        session.startRunning()
        
        // deviceをロックして設定
        // swift 2.0
        do {
            try camera.lockForConfiguration()
            // フレームレート
            camera.activeVideoMinFrameDuration = CMTimeMake(1, 30)
            
            camera.unlockForConfiguration()
        } catch _ {
        }
    }
    
    
    // 新しいキャプチャの追加で呼ばれる
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        // キャプチャしたsampleBufferからUIImageを作成
        let image:UIImage = self.captureImage(sampleBuffer)
        
        // 画像を画面に表示
        dispatch_async(dispatch_get_main_queue()) {
            self.imageView.image = image
            
            // UIImageViewをビューに追加
            self.view.addSubview(self.imageView)
            self.view.sendSubviewToBack(self.imageView)
        }
    }
    
    // sampleBufferからUIImageを作成
    func captureImage(sampleBuffer:CMSampleBufferRef) -> UIImage{
        
        // Sampling Bufferから画像を取得
        let imageBuffer:CVImageBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer)!
        
        // pixel buffer のベースアドレスをロック
        CVPixelBufferLockBaseAddress(imageBuffer, 0)
        
        let baseAddress:UnsafeMutablePointer<Void> = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)
        
        let bytesPerRow:Int = CVPixelBufferGetBytesPerRow(imageBuffer)
        let width:Int = CVPixelBufferGetWidth(imageBuffer)
        let height:Int = CVPixelBufferGetHeight(imageBuffer)
        
        
        // 色空間
        let colorSpace:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        
        //let bitsPerCompornent:Int = 8
        
        // swift 2.0
        let newContext:CGContextRef = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace,  CGImageAlphaInfo.PremultipliedFirst.rawValue|CGBitmapInfo.ByteOrder32Little.rawValue)!
        
        let imageRef:CGImageRef = CGBitmapContextCreateImage(newContext)!
        let resultImage = UIImage(CGImage: imageRef, scale: 1.0, orientation: UIImageOrientation.Right)
        
        return resultImage
    }
    
    
    // タップイベント.
    func tapedShutterButton(sender: UIButton) {
        print("タップ")
        takeStillPicture()
        
        self.imageView.alpha = 0.4
        
        UIView.animateWithDuration(0.5, animations: {
            self.imageView.alpha = 1
        })
    }
    
    func takeStillPicture(){
        if var _:AVCaptureConnection? = output.connectionWithMediaType(AVMediaTypeVideo){
            // アルバムに追加
            UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, nil, nil)
        }
    }
    
    func tapedCloseButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
