//
//  PluTempButton.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import UIKit

final class PluTempButton: UIButton {
    init(isActive: Bool = false) {
        super.init(frame: .zero)
        setButton(isActive: isActive)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonState(isActice: Bool) {
        self.setButton(isActive: isActice)
    }
}

private extension PluTempButton {
    func setButton(isActive: Bool) {
        self.setTitle("가입 완료", for: .normal)
        self.titleLabel?.font = .suite(.title1)
        self.setTitleColor(.designSystem(isActive ? .white : .gray300), for: .normal)
        self.backgroundColor = .designSystem(isActive ? .gray600 : .gray50)
        self.isUserInteractionEnabled = isActive
        self.clipsToBounds = false
        self.layer.cornerRadius = 8
    }
}
