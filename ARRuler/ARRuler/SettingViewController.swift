//
//  SettingViewController.swift
//  ARAlbum
//
//  Created by 文刀 on 2017/8/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
import UIKit
import StoreKit
import SafariServices
class SettingViewController: UIViewController,SKStoreProductViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        BaiduMobStat.default().pageviewStart(withName: "Setting")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        BaiduMobStat.default().pageviewEnd(withName: "Setting")
        
}
    @IBOutlet weak var closeButton: UIButton!
    @IBAction func closeAction() {
        self.dismiss(animated: true, completion:nil)
    }

    @IBOutlet weak var solarButton: UIButton!
    @IBAction func solarAction() {
        self.openAppStore(id: 1270095769)
        BaiduMobStat.default().logEvent("setting_solar_click", eventLabel: "点击AR太阳")

    }
    
    @IBOutlet weak var rulerButton: UIButton!
    @IBAction func rulerAction() {
        self.openAppStore(id: 1269968846)
        BaiduMobStat.default().logEvent("setting_ruler_click", eventLabel: "点击AR尺子")

    }


    @IBOutlet weak var albumButton: UIButton!
    @IBAction func ablumAction() {
        self.openAppStore(id: 1270095320)
        BaiduMobStat.default().logEvent("setting_album_click", eventLabel: "点击AR相册")
    }
    
    @IBOutlet weak var brushButton: UIButton!
    @IBAction func brushAction() {
        self.openAppStore(id: 1273579764)
        BaiduMobStat.default().logEvent("setting_brush_click", eventLabel: "点击AR画笔")
        
    }
    
    @IBOutlet weak var tetrisButton: UIButton!
    @IBAction func tetrisAction() {
        self.openAppStore(id: 1276498269)
        BaiduMobStat.default().logEvent("setting_tetris_click", eventLabel: "点击AR俄罗斯")
        
    }
    
    @IBOutlet weak var creditsButton: UIButton!
    @IBAction func creditsAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let showViewController = storyboard.instantiateViewController(withIdentifier: "CreditsViewController") as? CreditsViewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: showViewController)
        navigationController.navigationBar.isHidden = true;
        self.present(navigationController, animated: true, completion: nil)
        BaiduMobStat.default().logEvent("setting_arulerp_click", eventLabel: "打开设置页面")
    }


    @IBOutlet weak var  feedbackButton: UIButton!
    @IBAction func  feedbackAction() {
        
        let preferredLang = Bundle.main.preferredLocalizations.first! as NSString
        BaiduMobStat.default().logEvent("setting_feedback_click", eventLabel: "点击意见反馈")

        if (preferredLang == "zh-Hans")
        {
            self.openUrl(url: "https://smgui.kf5.com/kchat/29489")
        }
        else
        {
            let email = "developer@yaoyouguang.net"
            let url = NSURL(string: "mailto:\(email)")
            UIApplication.shared.openURL(url! as URL)
        }
    }

    func openAppStore(id: NSNumber){
        let appId = id
        let productView = SKStoreProductViewController()
        productView.delegate = self
        productView.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier : appId]) { (result, error) in
        }
        self.present(productView, animated: true, completion: nil)
    }
 
    func openUrl(url:String)
    {
        let urlWithString  = URL.init(string:url)
        let safariController = SFSafariViewController(url:urlWithString!,entersReaderIfAvailable: true)
        self.present(safariController, animated: true, completion: nil)

    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }


}
