//
//  HomeViewController.swift
//  Flickr
//
//  Created by Erdi Tunçalp on 25.03.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class HomeViewController: UIViewController, BindableType {
    
    // MARK: - Properties
    
    var viewModel: HomeViewModel!
    
    let disposeBag = DisposeBag()
    
    // MARK: - IBOutlets

    @IBOutlet weak private var collectionView: UICollectionView!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShowcaseCell.register(to: collectionView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = ShowcaseCell.Size
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    func bindViewModel() {
        viewModel.input.getRecentPhotos()
            .map { $0.photos.photo }
            .bind(to: collectionView.rx.items(cellType: ShowcaseCell.self))
            { (row, element, cell) in
                cell.imageView.kf.indicatorType = .activity
                cell.imageView.kf.setImage(with: URL(string: element.imageURL), placeholder: UIImage())
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Photo.self)
            .subscribe(onNext: { (element) in
                
            })
            .disposed(by: disposeBag)
    }


}

