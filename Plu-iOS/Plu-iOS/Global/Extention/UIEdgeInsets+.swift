//
//  UIEdgeInsets+.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/08.
//

import UIKit

extension UIEdgeInsets {
    init(side sidePadding: CGFloat) {
        self.init(top: 0, left: sidePadding, bottom: 0, right: sidePadding)
    }
    
    init(right rightSide: CGFloat, left leftSide: CGFloat) {
        self.init(top: 0, left: leftSide, bottom: 0, right: rightSide)
    }
}
