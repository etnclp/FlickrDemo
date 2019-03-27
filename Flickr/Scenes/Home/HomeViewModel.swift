//
//  HomeViewModel.swift
//  Flickr
//
//  Created by Erdi Tunçalp on 26.03.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Action
import RxSwift
import RxCocoa

protocol HomeViewModelInput {
    var nextPageTrigger: PublishSubject<Void> { get }
}

protocol HomeViewModelOutput {
    var elements: BehaviorRelay<[Photo]> { get }
    var error: PublishSubject<Swift.Error> { get }
}

protocol HomeViewModel {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

extension HomeViewModel where Self: HomeViewModelInput & HomeViewModelOutput {
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
}
