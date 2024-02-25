//
//  RegisterPopUpViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit
import Combine

import SnapKit

enum CheckPopUpType {
    case register, resign
}

final class CheckPopUpViewController: PopUpDimmedViewController {
    
    let viewModel: any CheckPopUpViewModel
    var cancelBag = Set<AnyCancellable>()
    
    let leftButtonSubject = PassthroughSubject<Void, Never>()
    let rightButtonSubject = PassthroughSubject<Void, Never>()
    
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
    
    private let rightButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.PopUp.Register.registerButtonTitle,
                 font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600,
                                foregroundColor: .white)
        .setLayer(cornerRadius: 8,
                  borderColor: .gray600)
    
    
    private let leftButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.PopUp.Register.checkButtonTitle,
                 font: .title1)
        .setBackForegroundColor(backgroundColor: .gray50,
                                foregroundColor: .gray300)
        .setLayer(cornerRadius: 8,
                  borderColor: .gray50)
    
    init(viewModel: some CheckPopUpViewModel) {
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

private extension CheckPopUpViewController {
    
    func setHierarchy() {
        view.addSubview(popUpBackgroundView)
        popUpBackgroundView.addSubviews(popUpTitle, popUpSubTitle, rightButton, leftButton)
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
        
        leftButton.snp.makeConstraints { make in
            make.top.equalTo(popUpSubTitle.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(rightButton.snp.leading).offset(-7)
            make.width.equalTo(rightButton.snp.width)
        }
        
        rightButton.snp.makeConstraints { make in
            make.top.equalTo(popUpSubTitle.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(leftButton.snp.width)
        }
    }
    
    func bindInput() {
        rightButton.tapPublisher
            .subscribe(self.rightButtonSubject)
            .store(in: &cancelBag)
        
        leftButton.tapPublisher
            .subscribe(self.leftButtonSubject)
            .store(in: &cancelBag)
    }
    
    func bind() {
        let input = CheckPopUpInput(leftButtonSubject: self.leftButtonSubject, rightButtonSubject: self.rightButtonSubject)
        let output = viewModel.transform(input: input)
        output.viewDidLoadPublisher
            .sink { [weak self] text in
                self?.popUpTitle.text = text.title
                self?.popUpSubTitle.text = text.subTitle
                self?.leftButton.setText(text: text.leftButtonTitle, font: .title1)
                self?.rightButton.setText(text: text.rightButtonTitle, font: .title1)
            }
            .store(in: &cancelBag)
    }
}
