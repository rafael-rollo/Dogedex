//
//  DogeCell.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit
import AlamofireImage

class DogeCell: UICollectionViewCell, ReusableView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        layoutAttributes.frame.size.height = size.height

        layoutIfNeeded()
        return layoutAttributes
    }
    
    func setup(from url: URL) {
        imageView.af.setImage(withURL: url)
    }
}

extension DogeCell: ViewCode {
    
    func addTheme() {
        layer.masksToBounds = true
        layer.cornerRadius = 12
    }
    
    func addViews() {
        addSubview(imageView)
    }
    
    func addConstraints() {
        imageView.constrainTo(edgesOf: self)
    }
    
}
