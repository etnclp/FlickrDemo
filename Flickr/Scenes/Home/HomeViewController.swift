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
    
    private(set) var disposeBag = DisposeBag()
    
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
    
    // MARK: - Binding
    
    func bindViewModel() {
        viewModel.output.elements
            .bind(to: collectionView.rx.items(cellType: ShowcaseCell.self))
            { (row, element, cell) in
                cell.titleLabel.text = element.title
                cell.userNameLabel.text = element.ownername
                cell.imageView.contentMode = .scaleAspectFill
                cell.imageView.kf.indicatorType = .activity
                cell.imageView.kf.setImage(with: URL(string: element.imageURL), placeholder: UIImage())
                
                cell.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped)))
            }
            .disposed(by: disposeBag)
        
        viewModel.output.error
            .subscribe(onNext: { error in
                log.error("Error: \(error)")
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.reachedBottom
            .bind(to: viewModel.input.nextPageTrigger)
            .disposed(by: disposeBag)
        
        viewModel.input.nextPageTrigger.onNext(())
    }
    
    // MARK: - Actions
    
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        if let image = (sender.view as? UIImageView)?.image {
            self.showFullscreenImage(image)
        }
    }
    
    private func showFullscreenImage(_ image: UIImage) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        let imageView = UIImageView(image: image)
        
        imageView.frame = UIScreen.main.bounds
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        view.addSubview(imageView)
    }
    
    @objc private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }

}


