//
//  NotificationBannerView.swift
//  ToastTestProject
//
//  Created by 김현구 on 2/6/24.
//

import Foundation
import UIKit
import RxSwift

public enum BannerStyle: Int {
    case danger
    case info
    case success
    case warning
    
    var color: UIColor {
        switch self {
            case .danger:
                return UIColor(red:0.90, green:0.31, blue:0.26, alpha:1.00)
            case .info:
                return UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00)
            case .success:
                return UIColor(red:0.22, green:0.80, blue:0.46, alpha:1.00)
            case .warning:
                return UIColor(red:1.00, green:0.66, blue:0.16, alpha:1.00)
        }
    }
}

class ToastBannerView: UIView {
    let title = UILabel()
    
    private var topConstaint: NSLayoutConstraint? = nil
    private var isDismiss = false
    private var originRect: CGRect? = nil
    private var height: CGFloat = 0
    private let disposeBag = DisposeBag()
    
    let topMargin: CGFloat = 6
    let leftMargin: CGFloat = 30
    let animationTime: CGFloat = 0.3
    let dissmisTime: CGFloat = 2.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    init(title: String, style: BannerStyle = .info) {
        super.init(frame: CGRect())
        self.title.text = title
        self.backgroundColor = style.color
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        guard let vw = keyWindow else { return }
        
        vw.addSubview(self)
        addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.numberOfLines = 0
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: title.font.pointSize)

        let titleWidth = (self.maxWidth ?? (2 * leftMargin)) - (2 * leftMargin)
        let titleheight = title.getHeight(width: titleWidth)
        height = safeTopHeight + titleheight + (2 * topMargin)
        title.frame = CGRect(x: leftMargin, y: safeTopHeight + topMargin - height, width: (self.maxWidth ?? (2 * leftMargin)) - (2 * leftMargin), height: titleheight)
        
        translatesAutoresizingMaskIntoConstraints = false
        frame = CGRect(x: 0, y: -height, width: self.maxWidth ?? 0, height: height)
        vw.backgroundColor = .green
    }
    
    func registerEvent() {
        RxEvent.instance.addBannerStackEvent(disposeBag: disposeBag) { bannerStackEvent in
            UIView.animate(withDuration: self.animationTime, animations: {
                self.setFrameY(height: bannerStackEvent.size.height)
            })
        }
    }
    
    func show() {
        let size = CGSize(width: frame.width, height: title.frame.height + (2 * topMargin))
        RxEvent.instance.updateBannerStackEvent(bannerStackEvent: BannerStackEvent(size: size))
        UIView.animate(withDuration: animationTime, animations: {
            self.setFrameY(height: self.height)
            self.title.setFrameY(height: self.height)
            self.superview?.layoutIfNeeded()
            self.registerEvent()
            }) { (completed) in
                DispatchQueue.main.asyncAfter(deadline: .now() + self.dissmisTime) {
                    self.dismiss()
                }
            }
    }
    
    func dismiss() {
        if (isDismiss) {
            return
        }
        
        isDismiss = true
        UIView.animate(withDuration: animationTime, animations: {
            self.setFrameY(height: -self.height)
            self.title.setFrameY(height: -self.height)
            self.superview?.layoutIfNeeded()
            }) { (completed) in
                self.removeFromSuperview()
            }
    }

}
