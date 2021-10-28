//
//  OpenSans+UIFont.swift
//  Dogedex
//
//  Created by rafael.rollo on 28/10/21.
//

import UIKit

enum OpenSansFonts: String {
    case regular = "OpenSans"
    case italic = "OpenSans-Italic"
    case light = "OpenSans-Light"
    case lightItalic = "OpenSansLight-Italic"
    case semibold = "OpenSans-Semibold"
    case semiboldItalic = "OpenSans-SemiboldItalic"
    case bold = "OpenSans-Bold"
    case boldItalic = "OpenSans-BoldItalic"
    case extrabold = "OpenSans-Extrabold"
    case extraboldItalic = "OpenSans-ExtraboldItalic"
}

extension UIFont {
    static func openSans(_ font: OpenSansFonts = .regular, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: font.rawValue, size: size) else {
            fatalError("Failed to load the Open Sans font.")
        }
        
        return UIFontMetrics.default.scaledFont(for: font)
    }
}
