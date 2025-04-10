//
//  FontManaget.swift
//  habits_app
//
//  Created by Home PC on 3/20/25.
//

import Foundation
import UIKit

enum Font {
    case original
    case fancy
}

enum FontSize {
    case small
    case medium
    case large
}

class FontManager {
    
    ///Font names
    private static let originalFontName =  "Didot"//"ArialRoundedMTBold"
    
    ///Font sizes
    private static let fontSizeSmall:CGFloat = 15
    private static let fontSizeMedium:CGFloat = 20
    private static let fontSizeLarge:CGFloat = 25
    
    /**
        
     */
    static func getFont(style: Font = .original, size: CGFloat) -> UIFont {
        switch style {
        case .original:
            return UIFont.systemFont(ofSize: size)
        case .fancy:
            return UIFont(name: "ArialRoundedMTBold", size: size)!
        }
    }
    
    static func getFont(style: Font = .original, size: FontSize = .medium) -> UIFont {
        
        var fontSize = fontSizeMedium
        
        switch size {
        case .small:
            fontSize = fontSizeSmall
        case .medium:
            fontSize = fontSizeMedium
        case .large:
            fontSize = fontSizeLarge
        }
        switch style {
        case .original:
            return UIFont(name: originalFontName, size: fontSize)!
        case .fancy:
            return UIFont(name: "ArialRoundedMTBold", size: fontSize)!
        }
    }
}


