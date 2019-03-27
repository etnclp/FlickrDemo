//
//  HomeViewModelImpl.swift
//  Flickr
//
//  Created by Erdi Tunçalp on 26.03.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa
import XCoordinator

class HomeViewModelImpl: HomeViewModel, HomeViewModelInput, HomeViewModelOutput {
    
    // MARK: - Properties
    
    private let router: AnyRouter<AppRoute>
    
    private let request: MoyaProvider<FlickrAPI> = .init()
    private var disposeBag: DisposeBag = .init()
    
    private var currentPage = 0
    private var lastPage = 5
    
    private var nextPage: Int? {
        guard currentPage < lastPage else { return nil }
        return currentPage + 1
    }
    
    // MARK: - HomeViewModelInput & HomeViewModelOutput
    
    var nextPageTrigger: PublishSubject<Void> = .init()
    
    var elements: BehaviorRelay<[Photo]> = .init(value: [])
    var error: PublishSubject<Swift.Error> = .init()
    
    // MARK: - Initialization
    
    init(router: AnyRouter<AppRoute>) {
        self.router = router
        
        nextPageTrigger
            .flatMap { _ -> Observable<PhotosResponse> in
                guard let next = self.nextPage else {
                    self.disposeBag = DisposeBag()
                    return .empty()
                }
                
                return self.getRecentPhotos(page: next)
                    .do(onError: { [weak self] error in
                        self?.error.onNext(error)
                    })
                    .catchError({ (error) -> Observable<PhotosResponse> in
                        .empty()
                    })
            }
            .scan([]) { (previous, current) -> [Photo] in
                return previous + current.photos.photo
            }
            .bind(to: elements)
            .disposed(by: disposeBag)
    }
    
    // MARK: -
    
    private func getRecentPhotos(page: Int = 1) -> Observable<PhotosResponse> {
        return request.rx.request(.getRecentPhotos(page: page))
            .map(PhotosResponse.self)
            .do(onSuccess: { [unowned self] response in
                self.currentPage = response.photos.page
                self.lastPage = response.photos.pages
            })
            .asObservable()
    }
    
}
