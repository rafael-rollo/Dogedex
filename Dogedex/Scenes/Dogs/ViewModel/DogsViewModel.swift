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
        var resource: Resource = .dogsByBreed(breed.title)
        
        if let subBreeds = breed.subBreeds, let subBreed = subBreeds.first {
            resource = .dogsByBreedAndSubBreed(breed.title, subBreed)
        }
        
        request(resource)
    }
    
    func loadDogePhotosOf(subBreed: String) {
        let resource = Resource.dogsByBreedAndSubBreed(breed.title, subBreed)
        request(resource)
    }
    
    private func request(_ resource: Resource) {
        APIRequest.execute(resource: resource) { [weak self] (dogePhotosResponse: DogePhotosResponse) in
            self?.dogePhotos = dogePhotosResponse.toDogePhotosURIs()

        } onFailure: { [weak self] error in
            debugPrint(error)
            self?.delegate?.dogsViewModel(self!, didErrorOccurLoadingDogs: error)
        }
    }
}
