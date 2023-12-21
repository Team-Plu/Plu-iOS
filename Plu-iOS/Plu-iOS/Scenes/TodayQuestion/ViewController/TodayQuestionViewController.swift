//
//  TodayQuestionViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 TodayQuestion. All rights reserved.
//

import UIKit
import Combine

import SnapKit

final class TodayQuestionViewController: UIViewController {
    
    private let viewModel: any TodayQuestionViewModel
    
    private let isShownAlarmPopUpSubject = PassthroughSubject<Void, Never>()
    private let navigationRightButtonTapped = PassthroughSubject<Void, Never>()
    private let myAnswerButtonTapped = PassthroughSubject<Void, Never>()
    private let otherAnswerButtonTapped = PassthroughSubject<Void, Never>()
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private var cancelBag = Set<AnyCancellable>()
    
    private let navigationBar = PLUNavigationBarView()
        .setRightButton(type: .logo)
        .setLeftButton(type: .textLogo)
    private lazy var questionCharcterImage = UIImageView()
    private let questionLabel = PLULabel(type: .head1,
                                         color: .gray700,
                                         alignment: .center,
                                         lines: 0, text: "진정한 행복이란\n 무엇이라 생각하나요?")
    private let explanationView = PLUExplanationView(text: "행복의 기준은 사람마다 달라요. \n부자가 되는 것, 여행을 다니는 것, 여유롭게 사는 것...\n여러분만의 행복의 기준은 무엇인가요? ")
    private let seeYouTommorowImage = UIImageView(image: ImageLiterals.Main.seeYouTommorowSpeechBubble)
    private let myAnswerButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.TodayQuestion.myAnswer.text, font: .title1)
        .setBackForegroundColor(backgroundColor: .gray600, foregroundColor: .white)
    private let otherAnswerButton = PLUButton(config: .bordered())
        .setText(text: StringConstant.TodayQuestion.everyAnswer.text, font: .title1)
        .setBackForegroundColor(backgroundColor: .gray50, foregroundColor: .gray300)
    private let explanationLabel = PLULabel(type: .caption, color: .gray300, text: StringConstant.TodayQuestion.explanation.text)
    
    init(viewModel: some TodayQuestionViewModel) {
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
        
        self.tabBarController?.tabBar.isHidden = false
        self.isShownAlarmPopUpSubject.send(())
        self.viewWillAppearSubject.send(())
    }
    
    private func bindInput() {
        navigationBar.rightButtonTapSubject
            .sink { [weak self] in
                self?.navigationRightButtonTapped.send(())
            }
            .store(in: &cancelBag)
        
        myAnswerButton.tapPublisher
            .sink { [weak self] in
                self?.myAnswerButtonTapped.send(())
            }
            .store(in: &cancelBag)
        
        otherAnswerButton.tapPublisher
            .sink { [weak self] in
                self?.otherAnswerButtonTapped.send(())
            }
            .store(in: &cancelBag)
    }
    
    private func bind() {
        let input = TodayQuestionViewModelInput(isShownAlarmPopupSubject: isShownAlarmPopUpSubject,
                                                navigationRightButtonTapped: navigationRightButtonTapped,
                                                myAnswerButtonTapped: myAnswerButtonTapped,
                                                otherAnswerButtonTapped: otherAnswerButtonTapped,
                                                viewWillAppearSubject: viewWillAppearSubject)
        
        let output = viewModel.transform(input: input)
        
        output.viewWillAppearSubject
            .receive(on: RunLoop.main)
            .sink { response in
                self.updateUI(response: response)
            }
            .store(in: &cancelBag)
    }
}

private extension TodayQuestionViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar, questionCharcterImage, questionLabel, explanationView,
                         seeYouTommorowImage, myAnswerButton, otherAnswerButton, explanationLabel)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        questionCharcterImage.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(42)
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
        
        seeYouTommorowImage.snp.makeConstraints { make in
            make.bottom.equalTo(myAnswerButton.snp.top)
            make.centerX.equalToSuperview()
        }
        
        myAnswerButton.snp.makeConstraints { make in
            make.bottom.equalTo(otherAnswerButton.snp.top).offset(-12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        otherAnswerButton.snp.makeConstraints { make in
            make.bottom.equalTo(explanationLabel.snp.top).offset(-8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(124)
            make.centerX.equalToSuperview()
        }
    }
    
    func updateUI(response: TodayQuestionResponse) {
        let explanationIsHidden = response.myAnswerButtonState
        questionCharcterImage.image = response.todayQuestionImage.image
        myAnswerButton.isActive(state: response.myAnswerButtonState)
        otherAnswerButton.isActive(state: response.othertAnswerButtonState)
        seeYouTommorowImage.isHidden = explanationIsHidden
    }
}
