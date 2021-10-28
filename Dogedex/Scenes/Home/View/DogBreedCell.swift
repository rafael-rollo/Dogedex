//
//  DogBreedCell.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogBreedCell: UITableViewCell, ReusableView {
    
    static let height: CGFloat = 70
        
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .openSans(.semibold, size: 16)
        return label
    }()
    
    private lazy var navigationIndicatorIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    private lazy var containerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            label, navigationIndicatorIconView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 24
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(from breed: Breed) {
        label.text = breed.title.capitalized
        
        navigationIndicatorIconView.image = UIImage(systemName: "arrow.forward")?
            .withRenderingMode(.alwaysTemplate)
    }
}

extension DogBreedCell: ViewCode {
    func addViews() {
        addSubview(containerView)
    }
    
    func addConstraints() {
        containerView.constrainTo(edgesOf: self)
    }
    
    func addTheme() {
        let backgroundView = UIView(frame: bounds)
        backgroundView.backgroundColor = .quaternaryLabel
        
        selectedBackgroundView = backgroundView
    }
}
