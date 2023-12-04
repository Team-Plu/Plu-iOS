//
//  CGColor+.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/04.
//

import UIKit

extension CGColor {
    static func designSystem(_ color: Palette) -> CGColor? {
        UIColor(named: color.rawValue)?.cgColor
    }
}
