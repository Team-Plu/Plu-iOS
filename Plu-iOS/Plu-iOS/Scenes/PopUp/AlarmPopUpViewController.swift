//
//  AlarmPopUpViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/12.
//  Copyright (c) 2023 AlarmPopUp. All rights reserved.
//

import UIKit

import SnapKit

final class AlarmPopUpViewController: PopUpDimmedViewController {
    
    private let popUpBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.white)
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let popUpTitle = PLULabel(type: .head2, color: .gray700, lines: 2, text: "매일 저녁 10시\n알림을 드려도 될까요?")
    
    private let popUpSubTitle = PLULabel(type: .body2M, color: .gray500, lines: 2, text: "오늘의 질문을 놓치지 않을 수 있어요\n필요없는 알림은 보내지 않을게요!")
    
    private lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("알림을 받을래요", for: .normal)
        button.backgroundColor = .designSystem(.gray600)
        button.setTitleColor(.designSystem(.white), for: .normal)
        button.titleLabel?.font = .suite(.title1)
        button.addTarget(self, action: #selector(agreeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var disAgreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("괜찮아요", for: .normal)
        button.setTitleColor(.designSystem(.gray500), for: .normal)
        button.titleLabel?.font = .suite(.body2M)
        button.addTarget(self, action: #selector(disAgreeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init() {
        super.init()
        setUp()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func agreeButtonTapped() {
        print("확인버튼 눌림")
    }
    
    @objc func disAgreeButtonTapped() {
        print("취소버튼 눌림")
    }
    
}

private extension AlarmPopUpViewController {
    func setUp() {
        view.addSubview(popUpBackgroundView)
        popUpBackgroundView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(200)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        popUpBackgroundView.addSubviews(popUpTitle, popUpSubTitle, agreeButton, disAgreeButton)
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
        
        agreeButton.snp.makeConstraints { make in
            make.top.equalTo(popUpSubTitle.snp.bottom).offset(120)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(44)
        }
        
        disAgreeButton.snp.makeConstraints { make in
            make.top.equalTo(agreeButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(44)
        }
    }
}
