//
//  PluTextField.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/10.
//

import UIKit

final class PLUTextField: UITextField {
    
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
        
        static var clearPadding: UIEdgeInsets {
            return .init(offset: self.clearButtonPadding.rawValue)
        }
    }
    
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
        guard let placeholder = StringConstant.Nickname.placeHolder.description else { return }
        self.setPlaceholder(placeholder: placeholder, fontColor: .designSystem(.gray300), font: .suite(.body1M))
    }
    
    private func setBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = .designSystem(.gray100)
        self.layer.cornerRadius = 12
        self.clipsToBounds = false
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.inset(by: TextFieldConstant.clearPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: TextFieldConstant.textPadding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: TextFieldConstant.textPadding)
    }

    func setClearButton() {
        if let clearButton = self.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(ImageLiterals.Onboarding.eraseButton, for: .normal)
        }
        self.clearButtonMode = UITextField.ViewMode.whileEditing
    }
    
    func setTextfieldDefaultInput(input: String) {
        self.text = input
    }
}

