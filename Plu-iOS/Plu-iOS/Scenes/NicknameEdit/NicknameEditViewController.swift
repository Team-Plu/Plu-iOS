//
//  NicknameEditViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/11.
//  Copyright (c) 2023 NicknameEdit. All rights reserved.
//

import UIKit
import Combine

import SnapKit

final class NicknameEditViewController: UIViewController {
    
    private let navigationBar = PLUNavigationBarView()
        .setTitle(text: "프로필 수정")
        .setLeftButton(type: .back)
        .setRightButton(type: .text("완료"))
    
    private let textFieldSubject = PassthroughSubject<String, Never>()
    private var cancelBag = Set<AnyCancellable>()
    
    private let defaultProfileImage = PLUImageView(ImageLiterals.MyPage.profile92)
    private let nickNameTextField = PLUTextField()
    private let errorLabel = PLULabel(type: .body3, color: .error)
    private let nicknameLabel = PLULabel(type: .body3, color: .gray600, text: "닉네임")
    
    private let viewModel = NicknameEditViewModel(nickNameManager: NicknameManagerStub())
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        bindInput()
        bind()
        setKeyboard()
        
        /// 임시로 넣어놨습니다
        nickNameTextField.setTextfieldDefaultInput(input: "의성")
    }
    
    func setNickname(input: String) {
        nickNameTextField.setTextfieldDefaultInput(input: input)
    }
}

private extension NicknameEditViewController {
    func bind() {
        let input = NicknameEditViewModel.NicknameEditInput(textFieldSubject: textFieldSubject)
        let output = self.viewModel.transform(input: input)
        output.nickNameResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let isActice = $0.nextProcessButtonIsActive, let description = $0.errorDescription else { return }
                self?.errorLabel.text = description
                self?.navigationBar.setRightButtonState(isEnabled: isActice)
            }
            .store(in: &cancelBag)
        
        navigationBar.leftButtonTapSubject
            .sink { _ in
                print("왼쪽 버튼 tap")
            }
            .store(in: &cancelBag)
        
        navigationBar.rightButtonTapSubject
            .sink { _ in
                print("오른쪽 버튼")
            }
            .store(in: &cancelBag)
    }
}

private extension NicknameEditViewController {
    func setUI() {
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(nicknameLabel, defaultProfileImage, nickNameTextField, errorLabel, navigationBar)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        defaultProfileImage.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.size.equalTo(92)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(defaultProfileImage.snp.bottom).offset(64)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nickNameTextField.snp.top).offset(-4)
            make.leading.equalToSuperview().inset(20)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    func setKeyboard() {
        self.nickNameTextField.becomeFirstResponder()
    }
    
    func bindInput() {
        self.nickNameTextField.textPublisher
            .sink { self.textFieldSubject.send($0) }
            .store(in: &cancelBag)
    }
}
