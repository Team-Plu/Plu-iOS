//
//  UIButton+.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/15.
//

import UIKit

extension UIButton {
    func setUnderline(title: String?) {
        guard let title else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count))
        attributedString.addAttribute(.font,
                                      value: UIFont.suite(.body2M),
                                      range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
}
