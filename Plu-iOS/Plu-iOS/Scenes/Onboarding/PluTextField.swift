//
//  PluTextField.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/08.
//

import UIKit

final class PluTextField: UITextField {
    
    enum ClearButtonType {
        case hide, show
        
        var action: UITextField.ViewMode {
            switch self {
            case .hide: return .never
            case .show: return .always
            }
        }
    }
    
    enum TextFieldConstant: CGFloat {
        case clearButtonPadding = 16
        case textViewPadding = 20
            
        static var textPadding: UIEdgeInsets {
            return .init(side: self.textViewPadding.rawValue)
        }
    }
    
    var showClearButton: ClearButtonType = .show {
        didSet {
            self.rightViewMode = showClearButton.action
        }
    }
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Onboarding.eraseButton, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setUI()
        setPlaceHolder()
        setBorder()
        setClearButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .clear
        self.font = .suite(.body1M)
        self.textColor = .designSystem(.gray700)
        self.tintColor = .designSystem(.gray400)

    }
    
    private func setPlaceHolder() {
        self.setPlaceholder(placeholder: StringConstant.Onboarding.placeHolder.title, fontColor: .designSystem(.gray300), font: .suite(.body1M))
    }
    
    private func setBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = .designSystem(.gray100)
        self.layer.cornerRadius = 12
        self.clipsToBounds = false
    }
    
    private func setClearButton() {
        self.rightView = clearButton
        self.rightViewMode = .always
        self.leftView?.backgroundColor = .designSystem(.error)
    }
    
    @objc func clearButtonTapped() {
        self.text = ""
        self.showClearButton = .hide
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= TextFieldConstant.clearButtonPadding.rawValue
        return rect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: TextFieldConstant.textPadding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: TextFieldConstant.textPadding)
    }
}
