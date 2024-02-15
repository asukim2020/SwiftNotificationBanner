//
//  ViewController.swift
//  ToastTestProject
//
//  Created by 김현구 on 2/6/24.
//

import UIKit

class ViewController: RxViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        button.addRxTap(disposeBag: disposeBag) {
            
            let style = { () -> BannerStyle in
                switch Int.random(in: 0 ... 3) {
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
            
            let title = { () -> String in
                switch Int.random(in: 0 ... 9) {
                case 1:
                    return "test"
                case 2:
                    return "Real-time mobile to cloud data sync makes it easy to build interactive features that keep data up-to-date across multiple devices, users, and the backend."
                case 3:
                    return "Realm’s live objects mean data updated anywhere is automatically updated everywhere."
                case 4:
                    return "This Quick Start demonstrates how to use Realm with the Realm Swift SDK. Before you begin, ensure you have Installed the Swift SDK."
                case 5:
                    return "configuration parameter:"
                case 6:
                    return "To modify a todo, update its properties in a write transaction block:"
                case 7:
                    return "If you want to sync Realm data across devices, you can set up an Atlas App Services App and enable Device Sync. For more information on what you can do with App Services, see: App Services - Swift SDK."
                case 8:
                    return "Once you have a realm with a subscription, this example passes the realm and the user to another function where you can use the realm."
                case 9:
                    return "Enable anonymous authentication"
                default:
                    return "What does storing and querying data in Realm look like?"
                }
            }()
            
            let banner = BannerView(title: title, style: style, position: .top)
            banner.show()

        }
    }

}

