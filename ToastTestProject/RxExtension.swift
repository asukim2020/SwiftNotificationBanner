//
//  RxExtension.swift
//  ToastTestProject
//
//  Created by 김현구 on 2/6/24.
//

import Foundation
import RxSwift
import RxCocoa

extension UIButton {
//    throttle
    func addRxTap(disposeBag: DisposeBag, completion: @escaping () -> Void) {
        rx.tap
        // prevent double tap 500 ms
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe { event in
                completion()
            }
            .disposed(by: disposeBag)
    }
    
}

extension UIView {
    // view.next -> superView
    // superView.next -> View Controller
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    var currentVC: UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }
            .map { $0 as? UIWindowScene }
            .map { $0?.windows.first } ?? UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow
    }
    
    var maxWidth: CGFloat? {
        return keyWindow?.frame.width
    }
    
    var maxHeight: CGFloat? {
        return keyWindow?.frame.height
    }
    
    var safeTopHeight: CGFloat {
        return keyWindow?.safeAreaInsets.top ?? 0.0
    }
    
    var safeBottomHeight: CGFloat {
        return keyWindow?.safeAreaInsets.bottom ?? 0.0
    }
    
    func setFrameY(height: CGFloat) {
        frame = CGRect(x: frame.minX, y: frame.minY + height, width: frame.width, height: frame.height)
    }
}

extension UILabel {
    private var height: CGFloat {
        guard let text = text,
              let font = font else {
            return 0.0
        }
        return (text as NSString).size(withAttributes: [NSAttributedString.Key.font : font]).height
    }
    
    private var width: CGFloat {
        guard let text = text,
              let font = font else {
            return 0.0
        }
        return (text as NSString).size(withAttributes: [NSAttributedString.Key.font : font]).width + font.pointSize
    }
    
    func getHeight(width: CGFloat) -> CGFloat {
        return CGFloat((Int(self.width / width) + 1)) * self.height
    }
}

extension UIViewController {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    
    var safeTopHeight: CGFloat {
        return keyWindow?.safeAreaInsets.top ?? 0.0
    }
    
    var safeBottomHeight: CGFloat {
        return keyWindow?.safeAreaInsets.bottom ?? 0.0
    }
    
    var isInNavigationStack: Bool {
        guard let vcs = navigationController?.viewControllers else {
            return false
        }
        
        for vc in vcs {
            if vc == self {
                return true
            }
        }
        
        return false
    }
    
    func popToVC(animated: Bool = true) {
        guard let nc = navigationController else {
            return
        }
        
        if nc.visibleViewController == self {
            return
        }
        
        if isInNavigationStack {
            nc.popToViewController(self, animated: animated)
        } else {
            nc.popViewController(animated: animated)
        }
    }
    
}
