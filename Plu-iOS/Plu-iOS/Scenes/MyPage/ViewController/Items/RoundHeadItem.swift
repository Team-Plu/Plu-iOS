//
//  RoundHeadItem.swift
//  Plu-iOS
//
//  Created by uiskim on 2/5/24.
//

import UIKit

import Carbon

struct RoundHeadItem: IdentifiableComponent {
    var id: UUID {
        return UUID()
    }
    
    func render(in content: UIView) {
        content.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        content.backgroundColor = .designSystem(.white)
    }
    
    func renderContent() -> UIView {
        return .init()
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        .init(width: bounds.width, height: 32)
    }
}
