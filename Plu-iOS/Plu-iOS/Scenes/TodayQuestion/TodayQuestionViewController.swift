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
    
    let coordinator: TodayQuestionCoordinator
    
    private lazy var questionCharcterImage = UIImageView(image: self.setRandomImage())
    private let questionLabel = PLULabel(type: .head1,
                                         color: .gray700,
                                         alignment: .center,
                                         lines: 0, text: "진정한 행복이란\n 무엇이라 생각하나요?")
    private let explanationView = PLUExplanationView(text: "행복의 기준은 사람마다 달라요. \n부자가 되는 것, 여행을 다니는 것, 여유롭게 사는 것...\n여러분만의 행복의 기준은 무엇인가요? ")
    private let seeYouTommorowImage = UIImageView(image: ImageLiterals.Main.seeYouTommorowSpeechBubble)
    private let myAnswerButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.TodayQuestion.myAnswer.text, font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600, foregroundColor: .gray50)
    private let everyAnswerButtom = PLUButton(config: .bordered())
        .setText(text: StringConstant.TodayQuestion.everyAnswer.text, font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600, foregroundColor: .gray50)
    private let explanationLabel = PLULabel(type: .caption, color: .gray300, text: StringConstant.TodayQuestion.explanation.text)
    
    lazy var tempMyPageButton: UIButton = {
        let button = UIButton()
        button.setTitle("마이페이지", for: .normal)
        button.backgroundColor = .designSystem(.error)
        button.addTarget(self, action: #selector(mypageButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(coordinator: TodayQuestionCoordinator) {
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
        setAddTarget()
        setDelegate()
        setButtonHandler()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.coordinator.presentAlarmPopUpViewController()
    }
    
    @objc func mypageButtonTapped() {
        self.coordinator.showMyPageViewController()
    }
}

private extension TodayQuestionViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(questionCharcterImage, questionLabel, explanationView, seeYouTommorowImage, myAnswerButton, everyAnswerButtom, explanationLabel)
        view.addSubview(tempMyPageButton)
    }
    
    func setLayout() {
        questionCharcterImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(42)
            make.leading.equalToSuperview().inset(103)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(questionCharcterImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        explanationView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        // output 값에 따라 isHidden 처리
        seeYouTommorowImage.snp.makeConstraints { make in
            make.bottom.equalTo(myAnswerButton.snp.top)
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
        
        tempMyPageButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    func setAddTarget() {
        myAnswerButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        everyAnswerButtom.addTarget(self, action: #selector(everyAnswerTapped), for: .touchUpInside)
    }
    
    func setDelegate() {
        
    }
    
    func setButtonHandler() {
        myAnswerButton.setUpdateHandler(updateHandler: { button in
            var config = button.configuration
            config?.baseBackgroundColor = button.isSelected
            ? .designSystem(.gray600)
            : .designSystem(.gray50)
        })
    }
    
    // 추후에 ViewModel로 뺄 부분
    func setRandomImage() -> UIImage {
        let randomIndex = Int(arc4random_uniform(UInt32(ImageDummy.imageList.count)))
        return ImageDummy.imageList[randomIndex]
    }
    
    @objc func writeButtonTapped() {
        self.coordinator.showMyAnswerViewController()
    }
    
    @objc func everyAnswerTapped() {
        self.coordinator.showOtherAnswersViewController()
    }
}
