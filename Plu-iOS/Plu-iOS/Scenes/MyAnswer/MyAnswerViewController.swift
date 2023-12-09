//
//  MyAnswerViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 MyAnswer. All rights reserved.
//

import UIKit

import SnapKit

final class MyAnswerViewController: UIViewController {
    
    private let everyDayAnswerView = EverydayAnswerView()
    private let answerTextView = PLUTextView()
    private let answerCautionView = AnswerCautionView()
    private let bottomView = UIView()
    private let underLine = PLUUnserLine(color: .gray100)
    private let bottomTextLabel = PLULabel(type: .body1R, color: .gray700, text: StringConstant.MyAnswer.bottomView.text)
    private let answerStateSwitch = UISwitch()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - 컴포넌트 설정
        setUI()
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - autolayout설정
        setLayout()
        
        // MARK: - button의 addtarget설정
        setAddTarget()
        
        // MARK: - delegate설정
        setDelegate()
        
        everyDayAnswerView.configureUI(answer: OthersAnswer.dummmy())

    }
}

private extension MyAnswerViewController {
    func setUI() {
        view.backgroundColor = .white
    }
    
    func setHierarchy() {
        view.addSubviews(everyDayAnswerView, answerTextView, answerCautionView, bottomView)
        bottomView.addSubviews(underLine, bottomTextLabel, answerStateSwitch)
    }
    
    func setLayout() {
        everyDayAnswerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        answerTextView.snp.makeConstraints { make in
            make.top.equalTo(everyDayAnswerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(336)
        }
        
        answerCautionView.snp.makeConstraints { make in
            make.top.equalTo(answerTextView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
            make.height.equalTo(56)
        }
        
        underLine.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        bottomTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        answerStateSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
}
