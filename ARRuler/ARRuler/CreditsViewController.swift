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
class CreditsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        BaiduMobStat.default().pageviewStart(withName: "Credits")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        BaiduMobStat.default().pageviewEnd(withName: "Credits")
        
}
    @IBOutlet weak var closeButton: UIButton!
    @IBAction func closeAction() {
        self.dismiss(animated: true, completion:nil)
    }

    
    @IBOutlet weak var arluerButton: UIButton!
    @IBAction func arluerAction() {
        self.openUrl(url: "https://github.com/duzexu/ARuler")
        BaiduMobStat.default().logEvent("setting_aruler_click", eventLabel: "点击AR画笔")
        
    }
    
    @IBOutlet weak var arluerlButton: UIButton!
    @IBAction func arluerlAction() {
        self.openUrl(url: "https://github.com/duzexu/ARuler/blob/master/LICENSE")
        BaiduMobStat.default().logEvent("setting_arulerl_click", eventLabel: "点击AR俄罗斯")
        
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
