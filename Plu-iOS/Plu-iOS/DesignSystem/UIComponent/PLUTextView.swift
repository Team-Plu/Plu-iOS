//
//  PLUTextView.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/08.
//

import UIKit

final class PLUTextView: UITextView {
    let placeHolderLabel = PLULabel(type: .body1R,
                                    color: .gray300,
                                    text: StringConstant.MyAnswer.placeholder.text)
    
    init() {
        super.init(frame: .zero, textContainer: .none)
        
        self.font = .suite(.body1R)
        self.textColor = .designSystem(.gray700)
        self.backgroundColor = .designSystem(.background)
        self.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.tintColor = .designSystem(.gray700)
        
        self.placeHolderLabel.backgroundColor = .clear
        
        addSubview(placeHolderLabel)
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.topAnchor.constraint(equalTo: super.topAnchor).isActive = true
        placeHolderLabel.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 26).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
