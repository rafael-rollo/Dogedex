//
//  DogsViewModel.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import Foundation

protocol DogsViewModelDelegate: AnyObject {
    func updateViews()
}

class DogsViewModel {
    weak var delegate: DogsViewModelDelegate?
    
    var breed: Breed
    
    var dogePhotos: [URL] = [] {
        didSet {
            self.delegate?.updateViews()
        }
    }
    
    init(withSelectedBreed breed: Breed) {
        self.breed = breed
    }
    
    func loadDogePhotos() {
        APIRequest.execute(resource: .dogsBy(breed)) { [weak self] (dogePhotosResponse: DogePhotosResponse) in
            self?.dogePhotos = dogePhotosResponse.toDogePhotosURIs()

        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
}
