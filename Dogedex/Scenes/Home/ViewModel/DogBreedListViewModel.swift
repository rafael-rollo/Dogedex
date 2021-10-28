//
//  DogBreedListViewModel.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import Foundation

protocol DogBreedListViewModelDelegate: AnyObject {
    func updateViews()
}

class DogBreedListViewModel {
    weak var delegate: DogBreedListViewModelDelegate?
    
    var dogBreeds: [String] = [] {
        didSet {
            self.delegate?.updateViews()
        }
    }
    
    func loadBreeds() {
        dogBreeds = ["affenpinscher", "african", "airedale"]
    }
}
