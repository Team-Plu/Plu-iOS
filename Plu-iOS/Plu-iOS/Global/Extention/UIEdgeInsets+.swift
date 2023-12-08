//
//  UIEdgeInsets+.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/08.
//

import UIKit

extension UIEdgeInsets {
    static func sideEdge(padding: CGFloat) -> Self {
        return .init(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    static func sideEdge(leftPadding: CGFloat, rightPadding: CGFloat) -> Self {
        return .init(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
    }
}
