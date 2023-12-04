//
//  UIColor+Extension.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/04.
//

import UIKit

extension UIColor {
    static func designSystem(_ color: Palette) -> UIColor? {
        UIColor(named: color.rawValue)
    }
}
