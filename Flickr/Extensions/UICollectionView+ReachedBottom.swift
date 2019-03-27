//
//  UICollectionView+ReachedBottom.swift
//  Flickr
//
//  Created by Erdi Tunçalp on 28.03.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UICollectionView {
    
    var reachedBottom: Observable<Void> {
        return self.willDisplayCell
            .flatMapLatest({ (cell, indexPath) -> Observable<Void> in
                let trigger = (indexPath.section == self.base.numberOfSections - 1) &&
                    (indexPath.item == self.base.numberOfItems(inSection: indexPath.section) - 1)
                return trigger ? .just(()) : .empty()
            })
    }
}
