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

class RxEvent {
    static let instance = RxEvent()
    
    let bannerStackEvent = PublishSubject<BannerStackEvent>()
}

extension PublishSubject {
    func addEvent(disposeBag: DisposeBag, completion: @escaping (_ bannerStackEvent: Element) -> ()) {
        observe(on: MainScheduler.instance)
            .subscribe(onNext: { event in
                completion(event)
            }).disposed(by: disposeBag)
    }
}
