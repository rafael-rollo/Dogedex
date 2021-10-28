//
//  ViewController.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogBreedListViewController: UITableViewController {

    override func loadView() {
        super.loadView()
        
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension DogBreedListViewController: ViewCode {
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
}
