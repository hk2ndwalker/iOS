//
//  ViewStyles.swift
//  ActionTimer
//
//  Created by KITANO on 2020/02/13.
//  Copyright © 2020 kitano. All rights reserved.
//

import UIKit

/// String extension for convenient of substring
extension String {

    /// Index with using position of Int type
    func index(at position: Int) -> String.Index {
        return index((position.signum() >= 0 ? startIndex : endIndex), offsetBy: position)
    }

    /// Subscript for using like a "string[start..<end]"
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(at: bounds.lowerBound)
        let end = index(at: bounds.upperBound)
        return String(self[start..<end])
    }
}

extension UIColor {

    /// Convenience initializer
    /// - Parameter rgba: Hexadecimal-String
    convenience init(rgba: String) {
        let r = Int(rgba[0..<2], radix: 16)!
        let g = Int(rgba[2..<4], radix: 16)!
        let b = Int(rgba[4..<6], radix: 16)!
        let a = CGFloat(rgba.count >= 8 ? Int(rgba[6..<8], radix: 16)! : 255) / 255.0
        self.init(r: r, g: g, b: b, a: a)
    }

    /// Convenience initializer
    /// - Parameters:
    ///   - r: Red color (0...255)
    ///   - g: Green color (0...255)
    ///   - b: Blue color (0...255)
    ///   - a: Alpha (0.0...1.0)
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
}

extension UIFont {
    
    static let inputText = UIFont(name: "AvenirNext-Regular", size: 17)!
    
    static let placeholderText = UIFont.inputText

    static let toolbarButtonTitle = UIFont(name: "AvenirNext-Medium", size: 16)!
}

extension UIColor {
    
    static let placeholderText = UIColor(rgba: "7d7c7a80")

    static let doneButton = UIColor(rgba: "246eb9a0")
    
    static let clearButton = UIColor(rgba: "7d7c7a80")
}
