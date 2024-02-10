//
//  ViewController.swift
//  ToastTestProject
//
//  Created by 김현구 on 2/6/24.
//

import UIKit
import NotificationBannerSwift

class ViewController: RxViewController {

    @IBOutlet weak var button: UIButton!
    var count = 0
    var banner: TestNotificationBannerView? = nil
    var isShow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button.addRxTap(disposeBag: disposeBag) {
//            self.prevBanner?.dismiss()
            self.count += 1
////            let banner = NotificationBanner(title: "title \(self.count)", subtitle: "subtitle", style: .success)
//            let banner = StatusBarNotificationBanner(title: "title \(self.count)", style: .success)
//            banner.show()
            
//            if self.isShow {
//                self.banner?.dismiss()
////                self.banner = nil
//            } else {
//                self.banner = TestNotificationBannerView()
//                self.banner?.show()
//            }
//            
//            self.isShow = !self.isShow
            
            self.banner = TestNotificationBannerView(title: "test \(self.count)", style: .success)
            self.banner?.show()

        }
    }

}

