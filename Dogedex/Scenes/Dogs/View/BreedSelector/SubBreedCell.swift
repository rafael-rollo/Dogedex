//
//  BreedCell.swift
//  Dogedex
//
//  Created by rafael.rollo on 30/10/21.
//

import UIKit

class SubBreedCell: UICollectionViewCell, ReusableView {
    
    struct LayoutProps {
        static let font: UIFont = .openSans(.bold, size: 14)
        static let color: UIColor = .label
        static let height: CGFloat = 34
        static let horizontalPadding: CGFloat = 16
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = LayoutProps.font
        label.textColor = LayoutProps.color
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with title: String, isSelected: Bool) {
        label.text = title.capitalized
        
        if isSelected {
            setSelectedStyle()
        }
    }
    
    func setSelectedStyle() {
        backgroundColor = .label
        label.textColor = .systemBackground
    }
}

extension SubBreedCell {
    static func getMinSize(for title: String) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: LayoutProps.font]
        let size = (title as NSString).size(withAttributes: fontAttributes)
        
        let adjustedWidth = size.width + LayoutProps.horizontalPadding * 2
        return CGSize(width: adjustedWidth, height: LayoutProps.height)
    }
}

extension SubBreedCell: ViewCode {
    
    func addTheme() {
        layer.masksToBounds = false
        layer.cornerRadius = LayoutProps.height / 2
        layer.borderWidth = 2
        layer.borderColor = LayoutProps.color.cgColor
    }
    
    func addViews() {
        addSubview(label)
    }
    
    func addConstraints() {
        label.constrainTo(edgesOf: self)
    }
    
}
