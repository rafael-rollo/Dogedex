//
//  DogViewController.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogsViewController: UICollectionViewController {
    
    private var viewModel: DogsViewModel
    
    init(with viewModel: DogsViewModel) {
        self.viewModel = viewModel
        
        let size =  UIScreen.main.bounds.width - 24
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = 12
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.breed.title.capitalized
        
        collectionView.register(DogeCell.self, forCellWithReuseIdentifier: DogeCell.reuseId)
        
        viewModel.loadDogePhotos()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dogePhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogeCell.reuseId, for: indexPath) as? DogeCell else {
            fatalError("Provide an appropriate item cell for DogsViewController's collection view")
        }
        
        cell.setup(from: viewModel.dogePhotos[indexPath.row])
        return cell
    }
    
}

extension DogsViewController: DogsViewModelDelegate {
    func updateViews() {
        collectionView.reloadData()
    }
}

extension DogsViewController: ViewCode {
    func addTheme() {
        collectionView.backgroundColor = .systemBackground
    }
}
