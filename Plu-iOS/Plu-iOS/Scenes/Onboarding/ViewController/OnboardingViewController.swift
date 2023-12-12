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
    
    var coordinator: AuthCoordinator
    
    private let textFieldSubject = PassthroughSubject<String, Never>()
    private var cancelBag = Set<AnyCancellable>()
    
    private let titleLabel = PLULabel(type: .head1, color: .gray700, text: StringConstant.Onboarding.title.description)
    private let subTitleLabel = PLULabel(type: .body2R, color: .gray500, text: StringConstant.Onboarding.subTitle.description)
    private let nickNameTextField = PLUTextField()
    private let errorLabel = PLULabel(type: .body3, color: .error)
    private var signInButton = PluTempButton()
    
    private let viewModel = OnboardingViewModel(manager: NicknameManagerStub())
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setKeyboard()
        setAddTarget()
        bindInput()
        bind()
    }
}

private extension OnboardingViewController {
    func bind() {
        let input = OnboardingViewModel.OnboardingInput(textFieldSubject: textFieldSubject)
        let output = self.viewModel.transform(input: input)
        output.nickNameResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let isActice = $0.nextProcessButtonIsActive, let description = $0.errorDescription else { return }
                self?.errorLabel.text = description
                self?.signInButton.setButtonState(isActice: isActice)
            }
            .store(in: &cancelBag)
    }
    
    func bindInput() {
        self.nickNameTextField.textPublisher
            .sink { [weak self] in self?.textFieldSubject.send($0) }
            .store(in: &cancelBag)
    }
}

private extension OnboardingViewController {

    func setUI() {
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(titleLabel, subTitleLabel, nickNameTextField, errorLabel, signInButton)
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
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }

    func setKeyboard() {
        self.nickNameTextField.becomeFirstResponder()
    }
    
    func setAddTarget() {
        self.signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func signInButtonTapped() {
        self.coordinator.showTabbarController()
    }
}
