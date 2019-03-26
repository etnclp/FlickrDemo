//
//  ShowcaseCell.swift
//  Ecom
//
//  Created by Erdi Tunçalp on 26.03.2019.
//  Copyright © 2019 River Software. All rights reserved.
//

import UIKit

class ShowcaseCell: UICollectionViewCell, SpecialCell {
    
    // MARK: - Properties
    
    static var Size: CGSize = {
        let width: CGFloat = (UIScreen.main.bounds.width - 55)/2
        let height = width * 1.3625
        return .init(width: width, height: height)
    }()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.hex("#E7EAF0").cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.9
    }

}
