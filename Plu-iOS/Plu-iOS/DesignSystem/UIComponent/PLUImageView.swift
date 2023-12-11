//
//  PLUImageView.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/11.
//

import UIKit

final class PLUImageView: UIImageView {
    
    init(_ image: UIImage?) {
        super.init(frame: .zero)
        self.image = image
        self.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
