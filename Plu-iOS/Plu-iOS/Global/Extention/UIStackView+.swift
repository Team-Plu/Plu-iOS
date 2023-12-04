//
//  UIStackView+.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import UIKit

extension UIStackView {
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
