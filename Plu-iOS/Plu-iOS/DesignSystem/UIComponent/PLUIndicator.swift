//
//  PLUIndicator.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/17.
//

import UIKit

final class PLUIndicator: UIActivityIndicatorView {
    init(parent: UIViewController) {
        super.init(style: .medium)
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.center = parent.view.center
        self.color = .designSystem(.gray600)
        self.hidesWhenStopped = true
        self.stopAnimating()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
