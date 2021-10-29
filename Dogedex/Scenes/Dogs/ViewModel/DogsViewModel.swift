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
        dogePhotos = [
            URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg")!,
            URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg")!,
            URL(string: "https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg")!
        ]
    }
}
