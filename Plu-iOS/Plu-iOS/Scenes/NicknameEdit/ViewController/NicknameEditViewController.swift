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
        .setTitle(text: StringConstant.Navibar.title.profileEdit)
        .setLeftButton(type: .back)
        .setRightButton(type: .text(StringConstant.Navibar.title.completeRightButton))
    
    private let navigationLeftButtonTapped = PassthroughSubject<Void, Never>()
    private let navigationRightButtonTapped = PassthroughSubject<String?, Never>()
    private var cancelBag = Set<AnyCancellable>()
    
    private let defaultProfileImage = PLUImageView(ImageLiterals.MyPage.profile92)
    private let nickNameTextField = PLUTextField()
    private let errorLabel = PLULabel(type: .body3, color: .error)
    private let nicknameLabel = PLULabel(type: .body3, color: .gray600, text: StringConstant.MyPage.nickName.description)
    
    private let viewModel: any NicknameEditViewModel
    
    init(viewModel: some NicknameEditViewModel) {
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
        bind()
        /// 임시로 넣어놨습니다
        nickNameTextField.setTextfieldDefaultInput(input: "의성")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBar()
    }
    
    func setNickname(input: String) {
        nickNameTextField.setTextfieldDefaultInput(input: input)
    }
    
    func setTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
}

private extension NicknameEditViewController {
    func bind() {
        let input = NicknameEditInput(textFieldSubject: self.nickNameTextField.textPublisher, naviagtionLeftButtonTapped: navigationLeftButtonTapped, naviagtionRightButtonTapped: navigationRightButtonTapped)
        let output = self.viewModel.transform(input: input)
        output.nickNameResultPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let isActice = $0.nextProcessButtonIsActive, let description = $0.errorDescription else { return }
                self?.errorLabel.text = description
                self?.navigationBar.setRightButtonState(isEnabled: isActice)
            }
            .store(in: &cancelBag)
        
        output.loadingViewSubject
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.navigationBar.setActivityIndicator(isShow: false, isImage: false)
            }
            .store(in: &cancelBag)
        
        navigationBar.leftButtonTapSubject
            .sink { [weak self] in
                self?.navigationLeftButtonTapped.send(())
            }
            .store(in: &cancelBag)
        
        navigationBar.rightButtonTapSubject
            .sink { [weak self] in
                self?.navigationBar.setActivityIndicator(isShow: true, isImage: false)
                self?.navigationRightButtonTapped.send(self?.nickNameTextField.text)
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
}
