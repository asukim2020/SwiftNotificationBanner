//
//  ViewController.swift
//  ToastTestProject
//
//  Created by 김현구 on 2/6/24.
//

import UIKit

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

