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
        navigationController.setViewControllers([controller], animated: false)
        
        rootViewController = controller
        return navigationController
    }
    
}
