//
//  OnboardingViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 Onboarding. All rights reserved.
//

import UIKit
import Combine

import SnapKit

final class OnboardingViewController: UIViewController {
    
    private let viewModel = OnboardingViewModel()
    
    private let textFieldSubject = CurrentValueSubject<String, Never>("")
    private var cancelBag = Set<AnyCancellable>()
    private let titleLabel = PLULabel(type: .head1, color: .gray700, text: StringConstant.Onboarding.title.title)
    private let subTitleLabel = PLULabel(type: .body2R, color: .gray500, text: StringConstant.Onboarding.subTitle.title)
    private let nickNameTextField = PluTextField()
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setKeyboard()
        bindInput()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private extension OnboardingViewController {
    func bind() {
        let input = OnboardingViewModel.OnboardingInput(textFieldSubject: textFieldSubject)
        let output = self.viewModel.transform(input: input)
        output.clearButtonTypePublisher
            .sink { mode in
                self.nickNameTextField.showClearButton = mode
            }
            .store(in: &cancelBag)

    }
    func setUI() {
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(titleLabel, subTitleLabel, nickNameTextField)
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(42)
            make.leading.equalToSuperview().inset(20)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(20)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(68)
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func bindInput() {
        self.nickNameTextField.textPublisher
            .sink { [weak self] in
                self?.textFieldSubject.send($0) }
            .store(in: &cancelBag)
    }
    

    func setKeyboard() {
        self.nickNameTextField.becomeFirstResponder()
//        self.hideKeyboardWhenTapAround()
    }
}
