//
//  AlarmPopUpViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//  Copyright (c) 2023 AlarmPopUp. All rights reserved.
//

import UIKit
import Combine

import SnapKit

final class AlarmPopUpViewController: PopUpDimmedViewController {
    
    enum ButtonType {
        case accept, reject
    }
    
    let buttonSubject = PassthroughSubject<AlarmPopUpViewController.ButtonType, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    let viewModel: AlarmPopUpViewModel
    
    private let popUpBackgroundView = PLUPopUpContainerView()
    
    private let popUpTitle = PLULabel(type: .head2,
                                      color: .gray700,
                                      backgroundColor: .white,
                                      alignment: .center,
                                      lines: 2,
                                      text: StringConstant.PopUp.Alarm.title)
    
    private let popUpSubTitle = PLULabel(type: .body2M,
                                         color: .gray500,
                                         backgroundColor: .white,
                                         alignment: .center,
                                         lines: 2,
                                         text: StringConstant.PopUp.Alarm.subTitle)
    
    private let alarmImage = PLUImageView(ImageLiterals.PopUp.alarm)

    
    private let acceptButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.PopUp.Alarm.acceptButtonTitle,
                 font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600,
                                foregroundColor: .white)
        .setLayer(cornerRadius: 8,
                  borderColor: .gray600)
    
    
    private let rejectButton = PLUButton(config: .plain())
        .setBackForegroundColor(backgroundColor: .white,
                                foregroundColor: .gray500)
        .underLine(title: StringConstant.PopUp.Alarm.rejectButtonTitle)
    
    init(viewModel: AlarmPopUpViewModel) {
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

private extension AlarmPopUpViewController {
    
    func setHierarchy() {
        view.addSubview(popUpBackgroundView)
        popUpBackgroundView.addSubviews(popUpTitle, popUpSubTitle, alarmImage, acceptButton, rejectButton)
    }
    
    func setLayout() {
        popUpBackgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.893)
        }
        
        popUpTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(80)
        }
        
        popUpSubTitle.snp.makeConstraints { make in
            make.top.equalTo(popUpTitle.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(68)
        }
        
        alarmImage.snp.makeConstraints { make in
            make.top.equalTo(popUpSubTitle.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(74)
            make.width.equalTo(69)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.top.equalTo(alarmImage.snp.bottom).offset(45)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(44)
        }
        
        rejectButton.snp.makeConstraints { make in
            make.top.equalTo(acceptButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(22)
            make.bottom.equalToSuperview().inset(32)
        }
    }
    
    func bindInput() {
        acceptButton.tapPublisher
            .sink { _ in
                self.buttonSubject.send(.accept)
            }
            .store(in: &cancelBag)
        
        rejectButton.tapPublisher
            .sink { _ in
                self.buttonSubject.send(.reject)
            }
            .store(in: &cancelBag)
    }
    
    func bind() {
        let input = AlarmPopUpInput(buttonSubject: buttonSubject)
        _ = viewModel.transform(input: input)
    }
}