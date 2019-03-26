//
//  HomeViewModelImpl.swift
//  Flickr
//
//  Created by Erdi Tunçalp on 26.03.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Foundation
import RxSwift
import XCoordinator

class HomeViewModelImpl: HomeViewModel, HomeViewModelInput, HomeViewModelOutput {
    
    // MARK: - Properties
    
    private let router: AnyRouter<AppRoute>
    
    // MARK: - HomeViewModel & HomeViewModelInput & HomeViewModelOutput
    
    // MARK: - Initialization
    
    init(router: AnyRouter<AppRoute>) {
        self.router = router
    }
    
    // MARK: -
    
    func getRecentPhotos() -> Observable<PhotosResponse> {
        return request.rx.request(.getRecentPhotos)
            .map(PhotosResponse.self)
            .asObservable()
    }
    
}
