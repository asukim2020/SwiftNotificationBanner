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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button.addRxTap(disposeBag: disposeBag) {
            self.count += 1
            ////            let banner = NotificationBanner(title: "title \(self.count)", subtitle: "subtitle", style: .success)
            //            let banner = StatusBarNotificationBanner(title: "title \(self.count)", style: .success)
            //            banner.show()
            
            let style = { () -> BannerStyle in
                switch self.count % 4 {
                case 1:
                    return .info
                case 2:
                    return .success
                case 3:
                    return .warning
                default:
                    return .danger
                }
            }()
                
            let banner = TestNotificationBannerView(title: "test \(self.count)", style: style)
            banner.show()

        }
    }

}

