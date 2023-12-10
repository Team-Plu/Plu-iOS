//
//  TodayQuestionViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 TodayQuestion. All rights reserved.
//

import UIKit

import SnapKit

final class TodayQuestionViewController: UIViewController {
    
    private let questionCharcterImage = UIImageView()
    private let questionLabel = PLULabel(type: .head1,
                                         color: .gray700,
                                         alignment: .center,
                                         lines: 0, text: "진정한 행복이란\n 무엇이라 생각하나요?")
    private let explanationView = PLUExplanationView(text: "행복의 기준은 사람마다 달라요. \n부자가 되는 것, 여행을 다니는 것, 여유롭게 사는 것...\n여러분만의 행복의 기준은 무엇인가요? ")
    private let myAnswerButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.TodayQuestion.myAnswer.text, font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600, foregroundColor: .white)
        .setLayer(cornerRadius: 8, borderColor: .gray600)
    private let everyAnswerButtom = PLUButton(config: .bordered())
        .setText(text: StringConstant.TodayQuestion.everyAnswer.text, font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600, foregroundColor: .white)
        .setLayer(cornerRadius: 8, borderColor: .gray600)
    private let explanationLabel = PLULabel(type: .caption, color: .gray300, text: StringConstant.TodayQuestion.explanation.text)

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

    }
}

private extension TodayQuestionViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(questionCharcterImage, questionLabel, explanationView, myAnswerButton, everyAnswerButtom, explanationLabel)
    }
    
    func setLayout() {
        questionCharcterImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(42)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(91)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionCharcterImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        explanationView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        myAnswerButton.snp.makeConstraints { make in
            make.bottom.equalTo(everyAnswerButtom.snp.top).offset(-12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        everyAnswerButtom.snp.makeConstraints { make in
            make.bottom.equalTo(explanationLabel.snp.top).offset(-8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(124)
            make.centerX.equalToSuperview()
        }
    }
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
}
