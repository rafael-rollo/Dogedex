//
//  DogViewController.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogsViewController: UIViewController {
    
    // MARK: - subviews
    private lazy var subBreedSelectorView: SubBreedSelector = {
        let view = SubBreedSelector()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var contentContainerView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            subBreedSelectorView,
            collectionView,
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentContainerView)
        return scrollView
    }()
    
    // MARK: - properties
    private var viewModel: DogsViewModel
    
    private var heightContraint: NSLayoutConstraint?
    
    // MARK: - view lifecycle
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
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        
        viewModel.delegate = self
        viewModel.loadDogePhotos()
        
        if let subBreeds = viewModel.breed.subBreeds {
            subBreedSelectorView.setup(with: subBreeds)
        }
    }
    
    func resizeCollectionView() {
        let totalItemHeight = collectionViewLayout.itemSize.height + collectionViewLayout.minimumLineSpacing
        let size = totalItemHeight * CGFloat(viewModel.dogePhotos.count) + 12
        
        guard let constraint = heightContraint else {
            heightContraint = collectionView.constrainHeight(to: size)
            return
        }
        
        constraint.constant = size
    }
}

// MARK: - view model delegation
extension DogsViewController: DogsViewModelDelegate {
    
    func dogsViewModel(_ viewModel: DogsViewModel, didLoadDogsBy breed: Breed, dogs: [URL]) {
        collectionView.reloadData()
        
        resizeCollectionView()
    }
    
    func dogsViewModel(_ viewModel: DogsViewModel, didErrorOccurLoadingDogs error: Error) {
        TopAlert.show(
            message: "Something went wrong loading the dog photos.",
            in: navigationController ?? self
        )
    }
    
}

// MARK: - sub breed delegation
extension DogsViewController: SubBreedSelectorDelegate {
    
    func subBreedSelector(_ view: SubBreedSelector, didSelectSubBreed subBreed: String) {
        viewModel.loadDogePhotosOf(subBreed: subBreed)
    }
    
}

// MARK: - collection view management
extension DogsViewController: UICollectionViewDataSource {
    
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

// MARK: - view code
extension DogsViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
    
    func addViews() {
        view.addSubview(scrollView)
    }
    
    func addConstraints() {
        scrollView.constrainTo(edgesOf: view)
        
        contentContainerView.constrainToTopAndSides(of: scrollView)
        contentContainerView.anchorToCenterX(of: scrollView)

        let contentViewBottomConstraint = contentContainerView.constrainToBottom(of: scrollView)
        contentViewBottomConstraint.priority = .defaultLow

        let contentViewCenterYConstraint = contentContainerView.anchorToCenterY(of: scrollView)
        contentViewCenterYConstraint.priority = .defaultLow
    }
    
}
