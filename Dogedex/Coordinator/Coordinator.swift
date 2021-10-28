//
//  Coordinator.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var rootViewController: UIViewController? { get set }

    @discardableResult func start() -> UIViewController
}

protocol StackCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}
