//
//  MyAnswerViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 MyAnswer. All rights reserved.
//

import UIKit

import SnapKit
import Combine

final class MyAnswerViewController: UIViewController {
    
    let coordinator: MyAnswerCoordinator
    
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = MyAnswerViewModel()
    private let keyboardStatyeType = PassthroughSubject<KeyboardType, Never>()
    private let textViewTextCountSubject = PassthroughSubject<String, Never>()
    
    private let everyDayAnswerView = PLUEverydayAnswerView()
    private lazy var answerTextView = PLUTextView()
    private let answerCautionView = AnswerCautionView()
    private let bottomView = UIView()
    private let underLine = PLUUnserLine(color: .gray100)
    private let bottomTextLabel = PLULabel(type: .body1R, color: .gray700, text: StringConstant.MyAnswer.bottomView.text)
    private let answerStateSwitch = UISwitch()
    
    private lazy var tempCompleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("임시완료버튼입니다", for: .normal)
        button.backgroundColor = .designSystem(.error)
        button.addTarget(self, action: #selector(completButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(coordinator: MyAnswerCoordinator) {
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
        setDelegate()
        everyDayAnswerView.configureUI(answer: OthersAnswer.dummmy())
        bind()
        bindInput()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        answerTextView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func bindInput() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification, object: nil)
            .sink { [weak self] _ in
                self?.keyboardStatyeType.send((.show))
            }
            .store(in: &cancelBag)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification, object: nil)
            .sink { [weak self] _ in
                self?.keyboardStatyeType.send((.hide))
            }
            .store(in: &cancelBag)
    }
    
    private func bind() {
        let input = MyAnswerViewModel.MyAnswerInput(keyboardStateSubject: keyboardStatyeType,
                                                    textViewTextCountSubject: textViewTextCountSubject)
        let output = viewModel.transform(input: input)
        
        output.keyboardStatePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.updateTextViewLayout(keyboardState: state)
            }
            .store(in: &cancelBag)
        
        output.textViewTextCountPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.answerTextView.placeHolderLabel.isHidden = state
            }
            .store(in: &cancelBag)
    }
    
    private func updateTextViewLayout(keyboardState: Bool) {
        let components = keyboardState ? bottomView : answerCautionView
        
        answerTextView.snp.remakeConstraints { make in
            make.top.equalTo(everyDayAnswerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(components.snp.top)
        }
    }
    
    @objc func completButtonTapped() {
        self.coordinator.presentRegisterPopUpViewController()
    }
}

// MARK: - UITextViewDelegate
extension MyAnswerViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textViewTextCountSubject.send(textView.text)
    }
}

private extension MyAnswerViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(everyDayAnswerView, answerTextView, answerCautionView, bottomView)
        bottomView.addSubviews(underLine, bottomTextLabel, answerStateSwitch)
        /// 나중에 삭제
        view.addSubview(tempCompleteButton)
    }
    
    func setLayout() {
        everyDayAnswerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        answerTextView.snp.makeConstraints { make in
            make.top.equalTo(everyDayAnswerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        answerCautionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-56)
            make.height.equalTo(160)
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
        
        tempCompleteButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(150)
        }
    }
    
    func setDelegate() {
        answerTextView.delegate = self
    }
}
