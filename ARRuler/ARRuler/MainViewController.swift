//
//  MainViewController.swift
//  ARAlbum
//
//  Created by 文刀 on 2017/8/17.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
import UIKit


class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        BaiduMobStat.default().pageviewStart(withName: "Main")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        BaiduMobStat.default().pageviewEnd(withName: "Main")

    }
    @IBOutlet weak var showRulerButton: UIButton!
    @IBAction func showRulerAction() {
        if (self.isSupport())
        {
            let storyboard = UIStoryboard(name: "Ruler", bundle: nil)
            guard let showViewController = storyboard.instantiateViewController(withIdentifier: "RulerViewController") as? RulerViewController else {
                return
            }
            let navigationController = UINavigationController(rootViewController: showViewController)
            navigationController.navigationBar.isHidden = true;
            self.present(navigationController, animated: true, completion: nil)
            BaiduMobStat.default().logEvent("main_showRuler_click", eventLabel: "打开量尺页面")
        }
        else
        {
            self.alertSupport()
            BaiduMobStat.default().logEvent("main_fail_click", eventLabel: "机型限制点击")
        }
    }
    
    
    @IBOutlet weak var settingButton: UIButton!
    @IBAction func showSetting() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let showViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: showViewController)
        navigationController.navigationBar.isHidden = true;
        self.present(navigationController, animated: true, completion: nil)
        BaiduMobStat.default().logEvent("main_setting_click", eventLabel: "打开设置页面")
    }

    func alertSupport()
    {
        let alertController = UIAlertController(title: NSLocalizedString("DeAuContent", comment: "访问限制说明"), message: nil,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title:NSLocalizedString("IKnow", comment: "我知道了"), style: .cancel,handler:nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func isSupport() -> Bool
    {
        if(UIDevice.current.modelName == "NOT")
        {
            return false
        }
        else
        {
            return true
        }
        
        
    }
}
//MARK: - UIDevice延展
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "NOT"
        case "iPod7,1":                                 return "NOT"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "NOT"
        case "iPhone4,1":                               return "NOT"
        case "iPhone5,1", "iPhone5,2":                  return "NOT"
        case "iPhone5,3", "iPhone5,4":                  return "NOT"
        case "iPhone6,1", "iPhone6,2":                  return "NOT"
        case "iPhone7,2":                               return "NOT"
        case "iPhone7,1":                               return "NOT"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2":                               return "iPhone 7 Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "NOT"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "NOT"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "NOT"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "NOT"
        case "iPad5,3", "iPad5,4":                      return "NOT"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "NOT"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "NOT"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "NOT"
        case "iPad5,1", "iPad5,2":                      return "NOT"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "NOT"
        case "i386", "x86_64":                          return "NOT"
        default:                                        return identifier
        }
    }
}
