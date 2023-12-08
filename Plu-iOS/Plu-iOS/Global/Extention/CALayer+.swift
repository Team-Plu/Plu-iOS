//
//  CALayer+.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1),
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = -4,
        blur: CGFloat = 16,
        spread: CGFloat = 0) {
            
            masksToBounds = false
            shadowColor = color.cgColor
            shadowOpacity = alpha
            shadowOffset = CGSize(width: x, height: y)
            shadowRadius = blur / 2.0
            if spread == 0 {
                shadowPath = nil
            } else {
                let dx = -spread
                let rect = bounds.insetBy(dx: dx, dy: dx)
                shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
}
