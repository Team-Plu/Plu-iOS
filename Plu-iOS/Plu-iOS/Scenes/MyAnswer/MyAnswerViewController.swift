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
    
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel = MyAnswerViewModel()
    private let keyboardWillShow = PassthroughSubject<Void, Never>()
    private let keyboardWillHide = PassthroughSubject<Void, Never>()
    
    private let everyDayAnswerView = EverydayAnswerView()
    private lazy var answerTextView = PLUTextView(text: StringConstant.MyAnswer.placeholder.text, textColor: .gray300, font: .body1R)
    private let answerCautionView = AnswerCautionView()
    private let bottomView = UIView()
    private let underLine = PLUUnserLine(color: .gray100)
    private let bottomTextLabel = PLULabel(type: .body1R, color: .gray700, text: StringConstant.MyAnswer.bottomView.text)
    private let answerStateSwitch = UISwitch()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        everyDayAnswerView.configureUI(answer: OthersAnswer.dummmy())
        addKeyboardObserver()
        bindInput()
        answerTextView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func bindInput() {
        let input = MyAnswerViewModel.MyAnswerInput(keyboardWillShowSubject: keyboardWillShow,
                                                    keyboardWillHideSubject: keyboardWillHide)
        let output = viewModel.transform(input: input)
        
        output.keyboardStatePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.updateTextViewLayout(keyboardState: state)
            }
            .store(in: &cancelBag)
    }
            
    private func addKeyboardObserver() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification, object: nil)
            .sink { [weak self] _ in
                self?.keyboardWillShow.send(())
            }
            .store(in: &cancelBag)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification, object: nil)
            .sink { [weak self] _ in
                self?.keyboardWillHide.send(())
            }
            .store(in: &cancelBag)
    }
    
    private func updateTextViewLayout(keyboardState: Bool) {
        if keyboardState {
            answerTextView.snp.remakeConstraints { make in
                make.top.equalTo(everyDayAnswerView.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(bottomView.snp.top)
            }
        } else {
            answerTextView.snp.remakeConstraints { make in
                make.top.equalTo(everyDayAnswerView.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(answerCautionView.snp.top)
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension MyAnswerViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .designSystem(.gray300) {
            textView.text = nil
            textView.textColor = .designSystem(.black)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .designSystem(.gray300)
            textView.text = StringConstant.MyAnswer.placeholder.text
        }
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
    }
    
    func setDelegate() {
        answerTextView.delegate = self
    }
}
