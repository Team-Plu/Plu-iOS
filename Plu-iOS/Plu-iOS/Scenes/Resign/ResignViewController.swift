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
    
    private var coordinator: MyPageCoordinator
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let navigationBar = PLUNavigationBarView()
        .setTitle(text: "탈퇴하기")
        .setLeftButton(type: .back)
    
    private let airElementImageView = UIImageView(image: ImageLiterals.MyPage.farewellCharacter)
    
    private let resignTitleLabel = PLULabel(type: .head1, color: .gray700, backgroundColor: .background, alignment: .center, lines: 2, text: StringConstant.Resign.resignTitleText)
    
    private let descriptionView = ResignDescriptionView()
    
    private let reuseButton = PLUButton(config: .filled())
        .setText(text: StringConstant.Resign.reuseText, font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600, foregroundColor: .white)
        .setLayer(cornerRadius: 8, borderColor: .gray600)
    
    private let resignButton = PLUButton(config: .filled())
        .setText(text: StringConstant.Resign.resignText, font: .title1)
        .setBackForegroundColor(backgroundColor: .gray50, foregroundColor: .gray300)
        .setLayer(cornerRadius: 8, borderColor: .gray50)
    
    init(coordinator: MyPageCoordinator) {
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
        setUpdateHandler()
        bindInput()
    }
    
    private func bindInput() {
        navigationBar.leftButtonTapSubject
            .sink { [weak self] _ in
                guard let self else { return }
                self.coordinator.pop()
            }
            .store(in: &cancelBag)
    }
}

private extension ResignViewController {
    func setUI() {
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubviews(airElementImageView,
                              resignTitleLabel,
                              descriptionView,
                              reuseButton,
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
        
        reuseButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resignButton.snp.makeConstraints { make in
            make.top.equalTo(reuseButton.snp.bottom).offset(12)
            make.leading.trailing.equalTo(reuseButton)
            make.height.equalTo(44)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
    }
    
    func setUpdateHandler() {
        reuseButton.setUpdateHandler { button in
            print("reuse button tapped : \(button.isSelected)")
        }
        
        resignButton.setUpdateHandler { button in
            print("reuse button tapped : \(button.isSelected)")
        }
    }
}
