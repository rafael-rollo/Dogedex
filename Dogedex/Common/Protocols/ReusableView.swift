//
//  ReusableView.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

/**
    Identifying Views that is retrieved by ReuseIdentifier to favor reusing
 */
protocol ReusableView: UIView {
    static var reuseId: String { get }
}

extension ReusableView {
    static var reuseId: String {
        return String(describing: self)
    }
}
