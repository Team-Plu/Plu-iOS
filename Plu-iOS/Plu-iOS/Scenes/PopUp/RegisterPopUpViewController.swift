//
//  RegisterPopUpViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//

import UIKit

import SnapKit

final class RegisterPopUpViewController: PopUpDimmedViewController {
    
    var coordinator: PopUpCoordinator
    
    private let popUpBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.white)
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let popUpTitle = PLULabel(type: .head2, color: .gray700, text: "이대로 글을 등록할까요?")
    
    private let popUpSubTitle = PLULabel(type: .body2M, color: .gray500, lines: 2, text: "한번글을 등록하고 나면\n글의 내용과 공개여부 수정이 불가능해요.")
    
    private lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록하기", for: .normal)
        button.backgroundColor = .designSystem(.gray600)
        button.setTitleColor(.designSystem(.white), for: .normal)
        button.titleLabel?.font = .suite(.title1)
        button.addTarget(self, action: #selector(agreeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var disAgreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시확인하기", for: .normal)
        button.setTitleColor(.designSystem(.gray500), for: .normal)
        button.titleLabel?.font = .suite(.body2M)
        button.addTarget(self, action: #selector(disAgreeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(coordinator: PopUpCoordinator) {
        self.coordinator = coordinator
        super.init()
        setUp()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func agreeButtonTapped() {
        self.coordinator.accept(type: .register)
    }
    
    @objc func disAgreeButtonTapped() {
        self.coordinator.dismiss()
    }
    
}

private extension RegisterPopUpViewController {
    func setUp() {
        view.addSubview(popUpBackgroundView)
        popUpBackgroundView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(310)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        popUpBackgroundView.addSubviews(popUpTitle, popUpSubTitle, agreeButton, disAgreeButton)
        popUpTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(60)
        }
        popUpSubTitle.snp.makeConstraints { make in
            make.top.equalTo(popUpTitle.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(48)
        }
        
        agreeButton.snp.makeConstraints { make in
            make.top.equalTo(popUpSubTitle.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(44)
            make.width.equalTo(100)
        }
        
        disAgreeButton.snp.makeConstraints { make in
            make.top.equalTo(popUpSubTitle.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
            make.width.equalTo(100)
        }
    }
}
