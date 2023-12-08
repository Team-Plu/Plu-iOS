//
//  PluTextField.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/08.
//

import UIKit

final class PluTextField: UITextField {
    
    enum TextFieldConstant: CGFloat {
        case clearButtonPadding = 16
        case textViewPadding = 20
            
        static var textPadding: UIEdgeInsets {
            return .sideEdge(padding: self.textViewPadding.rawValue)
        }
    }
    
    var showClearButton: UITextField.ViewMode = .always {
        didSet {
            self.rightViewMode = showClearButton
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
        self.tintColor = .designSystem(.error)

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
        self.showClearButton = .never
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
}
