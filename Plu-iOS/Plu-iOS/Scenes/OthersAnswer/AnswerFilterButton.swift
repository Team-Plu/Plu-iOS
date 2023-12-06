//
//  AnswerFilterButton.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/6/23.
//

import UIKit

@frozen
enum AnswerFilterButtonType {
    case latest
    case mostEmpathy
    
    var title: String {
        switch self {
        case .latest:
            return "최신순"
        case .mostEmpathy:
            return "공감순"
        }
    }
}

final class AnswerFilterButton: UIButton {
    
    init(buttonType: AnswerFilterButtonType) {
        super.init(frame: .zero)
        setLayer()
        setUpButton(type: buttonType)
        setHandler()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayer() {
        self.layer.cornerRadius = 15
        self.layer.borderColor = .designSystem(.gray500)
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
    
    private func setUpButton(type: AnswerFilterButtonType) {
        var config = UIButton.Configuration.bordered()
        var attrString = AttributedString(type.title)
        attrString.font = .suite(.body3)
        config.attributedTitle = attrString
        config.image = ImageLiterals.Respone.arrowDownSmall600
        config.imagePlacement = .trailing
        config.baseBackgroundColor = .designSystem(.background)
        config.baseForegroundColor = .designSystem(.gray500)
        self.configuration = config
        self.changesSelectionAsPrimaryAction = true
    }
    
    private func setHandler() {
        self.configurationUpdateHandler = { [weak self] button in
            var config = button.configuration
            config?.image = button.isSelected
            ? ImageLiterals.Respone.arrowUpSmall600
            : ImageLiterals.Respone.arrowDownSmall600
            self?.configuration = config
        }
    }
}
