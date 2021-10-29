//
//  DogsViewModel.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import Foundation

protocol DogsViewModelDelegate: AnyObject {
    func dogsViewModel(_ viewModel: DogsViewModel, didLoadDogsBy breed: Breed, dogs: [URL])
    func dogsViewModel(_ viewModel: DogsViewModel, didErrorOccurLoadingDogs error: Error)
}

class DogsViewModel {
    weak var delegate: DogsViewModelDelegate?
    
    var breed: Breed
    
    var dogePhotos: [URL] = [] {
        didSet {
            self.delegate?.dogsViewModel(self, didLoadDogsBy: breed, dogs: dogePhotos)
        }
    }
    
    init(withSelectedBreed breed: Breed) {
        self.breed = breed
    }
    
    func loadDogePhotos() {
        APIRequest.execute(resource: .dogsBy(breed)) { [weak self] (dogePhotosResponse: DogePhotosResponse) in
            self?.dogePhotos = dogePhotosResponse.toDogePhotosURIs()

        } onFailure: { [weak self] error in
            debugPrint(error)
            self?.delegate?.dogsViewModel(self!, didErrorOccurLoadingDogs: error)
        }
    }
}
