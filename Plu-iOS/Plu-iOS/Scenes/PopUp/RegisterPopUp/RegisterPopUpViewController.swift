//
//  RegisterPopUpViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit
import Combine

import SnapKit

final class RegisterPopUpViewController: PopUpDimmedViewController {
    
    enum ButtonType {
        case reCheck, register
    }
    
    let viewModel: RegisterPopUpViewModel
    var cancelBag = Set<AnyCancellable>()
    
    let buttonSubject = PassthroughSubject<ButtonType, Never>()
    
    private let popUpBackgroundView = PLUPopUpContainerView()
    
    private let popUpTitle = PLULabel(type: .head2,
                                      color: .gray700,
                                      backgroundColor: .white,
                                      alignment: .center,
                                      text: StringConstant.PopUp.Register.title)
    
    private let popUpSubTitle = PLULabel(type: .body2M,
                                         color: .gray500,
                                         backgroundColor: .white,
                                         alignment: .center,
                                         lines: 2,
                                         text: StringConstant.PopUp.Register.subTitle)
    
    private let registerButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.PopUp.Register.registerButtonTitle,
                 font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600,
                                foregroundColor: .white)
        .setLayer(cornerRadius: 8,
                  borderColor: .gray600)
    
    
    private let reCheckButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.PopUp.Register.checkButtonTitle,
                 font: .title1)
        .setBackForegroundColor(backgroundColor: .gray50,
                                foregroundColor: .gray300)
        .setLayer(cornerRadius: 8,
                  borderColor: .gray50)
    
    init(viewModel: RegisterPopUpViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        setHierarchy()
        setLayout()
        bindInput()
        bind()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RegisterPopUpViewController {
    
    func setHierarchy() {
        view.addSubview(popUpBackgroundView)
        popUpBackgroundView.addSubviews(popUpTitle, popUpSubTitle, registerButton, reCheckButton)
    }
    
    func setLayout() {
        popUpBackgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(311.seWidth)
            make.height.equalToSuperview().multipliedBy(0.236)
        }
        
        popUpTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.leading.trailing.equalToSuperview()
        }
        
        popUpSubTitle.snp.makeConstraints { make in
            make.top.equalTo(popUpTitle.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview()
        }
        
        reCheckButton.snp.makeConstraints { make in
            make.top.equalTo(popUpSubTitle.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(registerButton.snp.leading).offset(-7)
            make.width.equalTo(registerButton.snp.width)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(popUpSubTitle.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(reCheckButton.snp.width)
        }
    }
    
    func bindInput() {
        registerButton.tapPublisher
            .sink { _ in
                self.buttonSubject.send(.register)
            }
            .store(in: &cancelBag)
        
        reCheckButton.tapPublisher
            .sink { _ in
                self.buttonSubject.send(.reCheck)
            }
            .store(in: &cancelBag)
    }
    
    func bind() {
        let input = RegisterPopUpInput(buttonSubject: buttonSubject)
        _ = viewModel.transform(input: input)
    }
}
