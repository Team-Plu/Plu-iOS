//
//  PluePopUpContainerView.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/14.
//

import UIKit

final class PLUPopUpContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .designSystem(.white)
        self.clipsToBounds = false
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
