//
//  SpaceItem.swift
//  Plu-iOS
//
//  Created by uiskim on 2/5/24.
//

import UIKit
import Carbon

struct SpaceItem: IdentifiableComponent {
    var id: UUID {
        return UUID()
    }
    
    var height: CGFloat

    init(_ height: CGFloat) {
        self.height = height
    }

    func renderContent() -> UIView {
        UIView()
    }

    func render(in content: UIView) {
        content.backgroundColor = .designSystem(.background)
    }

    func referenceSize(in bounds: CGRect) -> CGSize? {
        CGSize(width: bounds.width, height: height)
    }
}
