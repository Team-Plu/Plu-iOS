//
//  PLUTextView.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/08.
//

import UIKit

final class PLUTextView: UITextView {
    init(text: String?, textColor: Palette, font: Font.SuiteType) {
        super.init(frame: .zero, textContainer: .none)
        
        self.font = .suite(font)
        self.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.text = text
        self.textColor = .designSystem(textColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
