//
//  BreedResponse.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import Foundation

struct BreedResponse: Codable {
    var all: [String: [String]]
    
    enum CodingKeys: String, CodingKey {
        case all = "message"
    }
    
    func toBreedList() -> [Breed] {
        return all.map { (key, value) in
            Breed(title: key, subBreeds: value.isEmpty ? nil : value)
        }
    }
}
