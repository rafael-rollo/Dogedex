//
//  DogViewController.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogsViewController: UIViewController {
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let size =  UIScreen.main.bounds.width - 24
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = 12
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(DogeCell.self, forCellWithReuseIdentifier: DogeCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        return collectionView
    }()
    
    private var viewModel: DogsViewModel
    
    init(with viewModel: DogsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        
        viewModel.delegate = self
        viewModel.loadDogePhotos()
    }
    
}

extension DogsViewController: DogsViewModelDelegate {
    
    func dogsViewModel(_ viewModel: DogsViewModel, didLoadDogsBy breed: Breed, dogs: [URL]) {
        collectionView.reloadData()
    }
    
    func dogsViewModel(_ viewModel: DogsViewModel, didErrorOccurLoadingDogs error: Error) {
        TopAlert.show(
            message: "Something went wrong loading the dog photos.",
            in: navigationController ?? self
        )
    }
    
}

extension DogsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dogePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogeCell.reuseId, for: indexPath) as? DogeCell else {
            fatalError("Provide an appropriate item cell for DogsViewController's collection view")
        }

        cell.setup(from: viewModel.dogePhotos[indexPath.row])
        return cell
    }
    
}

extension DogsViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
    
    func addViews() {
        view.addSubview(collectionView)
    }
    
    func addConstraints() {
        collectionView.constrainTo(edgesOf: view)
    }
    
}
