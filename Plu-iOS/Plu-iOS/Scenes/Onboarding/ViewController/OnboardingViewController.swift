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

enum OnboardingNavigationType {
    case backButtonTapped, signInButtonTapped
}

final class OnboardingViewController: UIViewController {
    
    private let textFieldSubject = PassthroughSubject<String, Never>()
    private let navigationSubject = PassthroughSubject<OnboardingNavigationType, Never>()
    private var cancelBag = Set<AnyCancellable>()
    
    private let navigationBar = PLUNavigationBarView()
        .setTitle(text: "회원가입")
        .setLeftButton(type: .back)
    
    private let titleLabel = PLULabel(type: .head1, color: .gray700, text: StringConstant.Onboarding.title.description)
    
    private let subTitleLabel = PLULabel(type: .body2R, color: .gray500, text: StringConstant.Onboarding.subTitle.description)
    
    private let nickNameTextField = PLUTextField()
    
    private let errorLabel = PLULabel(type: .body3, color: .error)
    
    private var signInButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.Onboarding.buttonTitle.description!, font: .title1)
        .setLayer(cornerRadius: 8)
    
    
    private let viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
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
        bindInput()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nickNameTextField.becomeFirstResponder()
    }
}

private extension OnboardingViewController {
    func bind() {
        let input = OnboardingInput(textFieldSubject: textFieldSubject, navigationSubject: navigationSubject)
        let output = self.viewModel.transform(input: input)
        output.nickNameResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let isActive = $0.nextProcessButtonIsActive, let description = $0.errorDescription else { return }
                self?.errorLabel.text = description
                self?.signInButton.isEnabled = isActive
                self?.signInButton.isActive(state: isActive)
            }
            .store(in: &cancelBag)
    }
    
    func bindInput() {
        self.nickNameTextField.textPublisher
            .sink { [weak self] in self?.textFieldSubject.send($0) }
            .store(in: &cancelBag)
        
        self.navigationBar.leftButtonTapSubject
            .sink { [weak self] in
                self?.navigationSubject.send(.backButtonTapped)
            }
            .store(in: &cancelBag)
        
        self.signInButton.tapPublisher
            .sink { [weak self] in
                self?.navigationSubject.send(.signInButtonTapped)
                self?.signInButton.isUserInteractionEnabled = false
            }
            .store(in: &cancelBag)
    }
}

private extension OnboardingViewController {

    func setUI() {
        self.signInButton.isActive(state: false)
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar, titleLabel, subTitleLabel, nickNameTextField, errorLabel, signInButton)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(42)
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
}
