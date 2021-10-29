//
//  DogViewController.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogsViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(size: 14)
        label.text = "a dog here!"
        return label
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
    }

}

extension DogsViewController: ViewCode {
    
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
    
    func addViews() {
        view.addSubview(label)
    }
    
    func addConstraints() {
        label.anchorToCenter(of: self.view)
    }
    
}
