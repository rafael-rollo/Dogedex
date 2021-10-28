//
//  ViewController.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

class DogBreedListViewController: UITableViewController {

    private var viewModel: DogBreedListViewModel
    
    init(viewModel: DogBreedListViewModel = DogBreedListViewModel()) {
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
        
        tableView.dataSource = self
        
        viewModel.loadBreeds()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dogBreeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.dogBreeds[indexPath.row]
        
        return cell
    }
    
}

extension DogBreedListViewController: ViewCode {
    func addTheme() {
        view.backgroundColor = .systemBackground
    }
}
