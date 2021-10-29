//
//  DogePhotosResponse.swift
//  Dogedex
//
//  Created by rafael.rollo on 29/10/21.
//

import Foundation

struct DogePhotosResponse: Codable {
    var all: [String]
    
    enum CodingKeys: String, CodingKey {
        case all = "message"
    }
    
    func toDogePhotosURIs() -> [URL] {
        return all.map { stringPath in
            URL(string: stringPath)!
        }
    }
}
