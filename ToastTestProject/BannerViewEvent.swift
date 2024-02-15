//
//  RxEvent.swift
//  ToastTestProject
//
//  Created by 김현구 on 2/11/24.
//

import RxSwift
import RxCocoa

class BannerStackEvent {
    let size: CGSize
    
    init(size: CGSize) {
        self.size = size
    }
}

class BannerViewEvent {
    static let instance = BannerViewEvent()
    
    let bannerStackEvent = PublishSubject<BannerStackEvent>()
}

extension PublishSubject {
    func addEvent(disposeBag: DisposeBag, completion: @escaping (_ event: Element) -> ()) {
        observe(on: MainScheduler.instance)
            .subscribe(onNext: { event in
                completion(event)
            }).disposed(by: disposeBag)
    }
}
