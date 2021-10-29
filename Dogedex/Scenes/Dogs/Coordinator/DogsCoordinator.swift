//
//  DogCoordinator.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogsCoordinator: StackCoordinator {

    var rootViewController: UIViewController?
    var navigationController: UINavigationController
    
    private var breed: Breed
    
    init(with breed: Breed, navigationController: UINavigationController = UINavigationController()) {
        self.breed = breed
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let viewModel = DogsViewModel(withSelectedBreed: breed)
        let controller = DogsViewController(with: viewModel)
        
        rootViewController = controller
        return controller
    }

}
