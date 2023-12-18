//
//  ResignViewController.swift
//  Plu-iOS
//
//  Created by 김민재 on 2023/12/04.
//  Copyright (c) 2023 Resign. All rights reserved.
//

import UIKit

import SnapKit

final class ResignViewController: UIViewController {
    
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

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setUpdateHandler()
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
                              resignButton)
        
    }
    
    func setLayout() {
        airElementImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(69)
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
        resignButton.addTarget(self, action: #selector(resignButtonTapped), for: .touchUpInside)
    }
    
    @objc func resignButtonTapped() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        let navigationController = UINavigationController()
        sceneDelegate.appCoordinator = AppCoordinatorImpl(navigationController: navigationController)
        sceneDelegate.appCoordinator?.startSplashCoordinator()
        sceneDelegate.window?.rootViewController = navigationController
        sceneDelegate.window?.makeKeyAndVisible()
    }
}

