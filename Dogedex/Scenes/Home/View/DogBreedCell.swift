//
//  DogBreedCell.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogBreedCell: UITableViewCell, ReusableView {
    
    static let height: CGFloat = 60
        
    private lazy var breedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .openSans(.semibold, size: 16)
        return label
    }()
    
    private lazy var subBreedslabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .openSans(.italic, size: 12)
        label.isHidden = true
        return label
    }()
    
    private lazy var breedTitlesView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            breedLabel,
            subBreedslabel
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 4
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private lazy var navigationIndicatorIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .secondaryLabel
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private lazy var containerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            breedTitlesView, navigationIndicatorIconView
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
        breedLabel.text = breed.title.capitalized
        
        if let subBreeds = breed.subBreeds {
            subBreedslabel.text = subBreeds
                .map({ $0.capitalized })
                .joined(separator: ", ")
            subBreedslabel.isHidden = false
        }
        
        navigationIndicatorIconView.image = UIImage(systemName: "arrow.forward")?
            .withRenderingMode(.alwaysTemplate)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        subBreedslabel.text = ""
        subBreedslabel.isHidden = true
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
