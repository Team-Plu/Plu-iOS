//
//  PLULabel.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/5/23.
//

import UIKit


final class PLULabel: UILabel {
    
    init(type: Font.SuiteType,
         color: Palette,
         backgroundColor: Palette = .white,
         alignment: NSTextAlignment = .left,
         lines: Int = 1,
         text: String? = nil) {
        super.init(frame: .zero)
        self.font = .suite(type)
        self.textColor = .designSystem(color)
        self.textAlignment = alignment
        self.text = text
        self.backgroundColor = .designSystem(backgroundColor)
        self.numberOfLines = lines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
