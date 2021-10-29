//
//  DogBreedListCoordinator.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogBreedListCoordinator: StackCoordinator {
    
    var rootViewController: UIViewController?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let controller = DogBreedListViewController()
        controller.flowDelegate = self
        
        navigationController.setViewControllers([controller], animated: false)
        
        rootViewController = controller
        return navigationController
    }

}

extension DogBreedListCoordinator: DogBreedListFlowDelegate {
    
    func dogBreedListViewController(_ controller: DogBreedListViewController, didSelectBreed breed: Breed) {
        let viewController = DogsCoordinator(with: breed, navigationController: navigationController).start()
        
        navigationController.pushViewController(viewController, animated: true)
    }

}
