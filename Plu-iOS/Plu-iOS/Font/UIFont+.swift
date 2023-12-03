//
//  UIFont+.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/03.
//

import UIKit

extension UIFont {
    
    public class func suite(_ type: Font.SuiteType) -> UIFont {
        let font = Font.SuiteFont(name: .suite, weight: type.Wight)
        return ._font(name: font.name, size: type.Size)
    }
    
    private static func _font(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }
}
