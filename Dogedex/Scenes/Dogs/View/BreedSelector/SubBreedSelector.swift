//
//  BreedSelector.swift
//  Dogedex
//
//  Created by rafael.rollo on 29/10/21.
//

import UIKit

class SubBreedSelector: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SubBreedCell.self,
                                forCellWithReuseIdentifier: SubBreedCell.reuseId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let insets = UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
        collectionView.contentInset = insets
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private var items: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with subBreeds: [String]) {
        self.items = subBreeds
        self.isHidden = false
    }
}

extension SubBreedSelector: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubBreedCell.reuseId, for: indexPath) as? SubBreedCell else {
            fatalError("Provide an appropriate cell for subbreeds collection view")
        }
        
        cell.title = items[indexPath.row]
        return cell
    }
}

extension SubBreedSelector: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.row]
        return SubBreedCell.getMinSize(for: item)
    }
}

extension SubBreedSelector: ViewCode {
    
    func addTheme() {
        backgroundColor = .systemBackground
    }
    
    func addViews() {
        addSubview(collectionView)
    }
    
    func addConstraints() {
        self.constrainHeight(to: 62)
        collectionView.constrainTo(edgesOf: self)
    }
    
}
