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
    
    private let bannerStackSubject = PublishSubject<BannerStackEvent>()
    var bannerStackEvent: Observable<BannerStackEvent> {
        return bannerStackSubject.asObservable()
    }
    
    func updateBannerStackEvent(bannerStackEvent: BannerStackEvent) {
        bannerStackSubject.onNext(bannerStackEvent)
    }
    
    func addBannerStackEvent(disposeBag: DisposeBag, completion: @escaping (_ bannerStackEvent: BannerStackEvent) -> ()) {
        bannerStackEvent.observe(on: MainScheduler.instance)
            .subscribe(onNext: { bannerStackEvent in
                completion(bannerStackEvent)
            }).disposed(by: disposeBag)
    }
}
