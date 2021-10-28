//
//  ViewCode.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import Foundation

protocol ViewCode {
    func addTheme()
    func addViews()
    func addConstraints()

    func setup()
}

extension ViewCode {
    func addTheme() {}
    func addViews() {}
    func addConstraints() {}

    func setup() {
        addTheme()
        addViews()
        addConstraints()
    }
}
