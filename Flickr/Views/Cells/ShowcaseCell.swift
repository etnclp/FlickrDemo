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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
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
        
        imageView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
    /** The UIImageView, the one that is on top, passes its UITouch object to the UIView underneath and conducts the hitTest. */
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view: UIView?
        
        if let testedView = imageView.hitTest(imageView.convert(point, from: self), with: event) {
            view = testedView
        }
        
        return view ?? super.hitTest(point, with: event)
    }
    
}

fileprivate extension UIImageView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
