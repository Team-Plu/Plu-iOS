//
//  PLUUnderLine.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/08.
//

import UIKit

final class PLUUnserLine: UIView {
    
    init(color: Palette) {
        super.init(frame: .zero)
        self.backgroundColor = .designSystem(color)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
