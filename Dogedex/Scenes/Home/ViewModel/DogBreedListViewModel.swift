//
//  DogBreedListViewModel.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import Foundation

protocol DogBreedListViewModelDelegate: AnyObject {
    func dogBreedListViewModel(_ viewModel: DogBreedListViewModel,
                               didLoadDogBreeds breeds: [Breed])
    func dogBreedListViewModel(_ viewModel: DogBreedListViewModel,
                              didErrorOccurLoadingBreeds error: Error)
}

class DogBreedListViewModel {
    weak var delegate: DogBreedListViewModelDelegate?
    
    var dogBreeds: [Breed] = [] {
        didSet {
            self.delegate?.dogBreedListViewModel(self, didLoadDogBreeds: dogBreeds)
        }
    }
    
    func loadBreeds() {
        APIRequest.execute(resource: .breeds) { [weak self] (breedResponse: BreedResponse) in
            self?.dogBreeds = breedResponse
                .toBreedList()
                .sorted(by: {$0.title < $1.title})
            
        } onFailure: { [weak self] error in
            debugPrint(error)
            self?.delegate?.dogBreedListViewModel(self!, didErrorOccurLoadingBreeds: error)
        }
    }
}
