//
//  ResignViewController.swift
//  Plu-iOS
//
//  Created by 김민재 on 2023/12/04.
//  Copyright (c) 2023 Resign. All rights reserved.
//

import UIKit
import Combine

import SnapKit

final class ResignViewController: UIViewController {
    
    private let navigationBackButtonTapped = PassthroughSubject<Void, Never>()
    private let checkBoxButtonTapped = PassthroughSubject<Bool, Never>()
    private let resignButtonTapped = PassthroughSubject<Void, Never>()
    
    private let viewModel: any ResignViewModel
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let navigationBar = PLUNavigationBarView()
        .setTitle(text: "탈퇴하기")
        .setLeftButton(type: .back)
    
    private let airElementImageView = UIImageView(image: ImageLiterals.MyPage.farewellCharacter)
    
    private let resignTitleLabel = PLULabel(type: .head1, color: .gray700, backgroundColor: .background, alignment: .center, lines: 2, text: StringConstant.Resign.resignTitleText)
    
    private let descriptionView = ResignDescriptionView()
    
    private let checkBoxButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_checkbox"), for: .normal)
        button.isSelected = false
        return button
    }()
    
    private let checkBoxDescription: UILabel = {
        let label = UILabel()
        label.font = .suite(.body3)
        label.textColor = .designSystem(.gray700)
        label.text = "(필수) 위 유의 사항을 모두 확인했으며 이에 동의합니다."
        label.textAlignment = .left
        return label
    }()
    
    private let resignButton = PLUButton(config: .filled())
        .setText(text: StringConstant.Resign.resignText, font: .title1)
        .setBackForegroundColor(backgroundColor: .gray50, foregroundColor: .gray300)
        .setLayer(cornerRadius: 8, borderColor: .gray50)
    
    init(viewModel: some ResignViewModel) {
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
        setTabBar()
    }
    
    private func bindInput() {
        navigationBar.leftButtonTapSubject
            .subscribe(self.navigationBackButtonTapped)
            .store(in: &cancelBag)
        
        checkBoxButton.tapPublisher
            .sink { [weak self] _ in
                guard let self else { return }
                self.checkBoxButton.isSelected.toggle()
                self.checkBoxButtonTapped.send(self.checkBoxButton.isSelected)
            }
            .store(in: &cancelBag)
        
        resignButton.tapPublisher
            .filter { self.checkBoxButton.isSelected }
            .subscribe(self.resignButtonTapped)
            .store(in: &cancelBag)
    }
    
    private func bind() {
        let input = ResignViewModelInput(
            navigationBackButtonTapped: navigationBackButtonTapped,
            checkBoxButtonTapped: checkBoxButtonTapped,
            resignButtonTapped: resignButtonTapped
        )
        let output = viewModel.transform(input: input)
        output.resignButtonStatePublisher
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.setButtonState(isChecked: $0)
            }
            .store(in: &cancelBag)
    }
    
    private func setButtonState(isChecked: Bool) {
        self.checkBoxButton.setImage(UIImage(named: isChecked ? "btn_checkbox_fill" : "btn_checkbox"), for: .normal)
        self.resignButton.setBackForegroundColor(backgroundColor: isChecked ? .gray600 : .gray50, foregroundColor: isChecked ? .white : .gray300)
    }
}

private extension ResignViewController {
    func setTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setUI() {
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubviews(airElementImageView,
                              resignTitleLabel,
                              descriptionView,
                              checkBoxButton,
                              checkBoxDescription,
                              resignButton,
                              navigationBar)
        
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        airElementImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(69)
            make.centerX.equalToSuperview()
        }
        
        resignTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(airElementImageView.snp.bottom).offset(16)
        }
        
        descriptionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resignTitleLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(36)
        }
        
        checkBoxButton.snp.makeConstraints { make in
            make.leading.equalTo(descriptionView.snp.leading)
            make.top.equalTo(descriptionView.snp.bottom).offset(20)
            make.size.equalTo(20)
        }
        
        checkBoxDescription.snp.makeConstraints { make in
            make.centerY.equalTo(checkBoxButton.snp.centerY)
            make.leading.equalTo(checkBoxButton.snp.trailing).offset(10)
            make.trailing.equalTo(descriptionView.snp.trailing)
        }
        
        resignButton.snp.makeConstraints { make in
            make.top.equalTo(checkBoxButton.snp.bottom).offset(70)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
}

