//
//  PLUTextView.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/08.
//

import UIKit

final class PLUTextView: UITextView {
    private let placeHolderLabel = PLULabel(type: .body1R,
                                            color: .gray300,
                                            text: StringConstant.PlaceHolder.textView.text)
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PLUTextView {
    func setHierarchy() {
        addSubviews(placeHolderLabel)
    }
    
    func setLayout() {
        placeHolderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
    }
}
