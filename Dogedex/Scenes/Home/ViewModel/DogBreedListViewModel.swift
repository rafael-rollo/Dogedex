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
    
    var dogBreeds: [Breed] = [] {
        didSet {
            self.delegate?.updateViews()
        }
    }
    
    func loadBreeds() {
        APIRequest.execute(resource: .breeds) { [weak self] (breedResponse: BreedResponse) in
            self?.dogBreeds = breedResponse
                .toBreedList()
                .sorted(by: {$0.title < $1.title})
            
        } onFailure: { error in
            print(error.localizedDescription)
            // TODO: do some handling code
        }
    }
}
