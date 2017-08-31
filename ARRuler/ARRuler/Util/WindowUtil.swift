//
//  WindowsUtil.swift
//  ARAlbum
//
//  Created by 文刀 on 2017/8/17.
//  Copyright © 2017年 Apple. All rights reserved.
//


import Foundation
import UIKit

protocol Overlayable
{
    func show()
    func hide()
}

class WindowUtil: Overlayable
{
    var overlayWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
    var stopButton = UIButton(type: UIButtonType.custom)
    var stopButtonColor = UIColor(red:0.30, green:0.67, blue:0.99, alpha:1.00)
    var onStopClick:(() -> ())?
    
    init ()
    {
        self.setupViews()
    }
    
    func initViews()
    {
        overlayWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        stopButton = UIButton(type: UIButtonType.custom)

    }

    
    func hide()
    {
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.stopButton.transform = CGAffineTransform(translationX:0, y: -30)
            }, completion: { (animated) in
                self.overlayWindow.backgroundColor = .clear
                self.overlayWindow.isHidden = true
                self.stopButton.isHidden = true
                self.stopButton.transform = CGAffineTransform.identity;
            })
            
        }
        
    }
    
    func setupViews ()
    {
        initViews()
        stopButton.setTitle(NSLocalizedString("StopRecordTop", comment: "录制视频中... 点此停止"), for: .normal)
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        stopButton.addTarget(self, action: #selector(stopRecording), for: UIControlEvents.touchDown)
        stopButton.frame = overlayWindow.frame
        overlayWindow.addSubview(stopButton)
        overlayWindow.windowLevel = CGFloat.greatestFiniteMagnitude
        
    }
    
    
    @objc func stopRecording()
    {
        BaiduMobStat.default().logEvent("show_recordStopTop_click", eventLabel: "顶部停止录制视频")
        onStopClick?()
    }
    
    func show()
    {
        DispatchQueue.main.async {
            self.stopButton.transform = CGAffineTransform(translationX: 0, y: -30)
            self.stopButton.backgroundColor = self.stopButtonColor
            self.overlayWindow.makeKeyAndVisible()
            UIView.animate(withDuration: 0.3, animations: {
                self.stopButton.transform = CGAffineTransform.identity
            }, completion: { (animated) in
                
            })
        }
        
    }
}

