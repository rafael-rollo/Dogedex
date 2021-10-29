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
    
    var breed: Breed
    
    init(withSelectedBreed breed: Breed) {
        self.breed = breed
    }
    
}
