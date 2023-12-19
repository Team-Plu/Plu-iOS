//
//  AnswerDetailViewController.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/11.
//

import UIKit
import Combine

import SnapKit

final class AnswerDetailViewController: UIViewController {

    private var cancleBag = Set<AnyCancellable>()
    private let coordinator: AnswerDetailCoordinator
    private let navigationBar = PLUNavigationBarView()
        .setLeftButton(type: .back)
    private let everyAnswerView = PLUEverydayAnswerView()
    private let contentView = UIView()
    private let answerScrollerView = UIScrollView()
    private let answerDetailLabel = PLULabel(type: .body1R, color: .gray700, backgroundColor: .background, lines: 0, text: "진정한 행복이란 추석 연휴에 엽떡을 먹는 것 엽떡은 정말 맛있기 때문입니다 엽떡 만세진정한 행복이란 추석 연휴에 엽떡을 먹는 것 엽떡은 정말 맛있기 때문입니다")
    private let sympathyButton = PLUButton(config: .bordered())
        .setImage(image: ImageLiterals.AnswerDetail.airEmpathyLargeActivated, placement: .leading, padding: 4)
        .setBackForegroundColor(backgroundColor: .background, foregroundColor: .pluRed)
        .setText(text: "공감 999", font: .body1M)
        .setLayer(cornerRadius: 15, borderColor: .pluRed)
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setDelegate()
        setButtonHandler()
        everyAnswerView.configureUI(answer: OthersAnswer.dummmy())
        bindInput()
        setTabBar()
    }
    
    init(coordinator: AnswerDetailCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindInput() {
        navigationBar.leftButtonTapSubject
            .sink { [weak self] in
                self?.coordinator.pop()
            }
            .store(in: &cancleBag)
    }
}

private extension AnswerDetailViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar, everyAnswerView, answerScrollerView)
        answerScrollerView.addSubview(contentView)
        contentView.addSubviews(answerDetailLabel, sympathyButton)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        everyAnswerView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        answerScrollerView.snp.makeConstraints { make in
            make.top.equalTo(everyAnswerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(self.answerScrollerView.contentLayoutGuide)
            make.width.equalToSuperview()
        }
        
        answerDetailLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        sympathyButton.snp.makeConstraints { make in
            make.top.equalTo(answerDetailLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
    
    func setButtonHandler() {
        sympathyButton.setUpdateHandler(updateHandler: { button in
            var config = button.configuration
            config?.background.backgroundColor = button.isSelected
            ? .designSystem(.pluRed)
            : .designSystem(.background)
            
            config?.baseForegroundColor = button.isSelected
            ? .designSystem(.white)
            : .designSystem(.pluRed)
            
            config?.image = button.isSelected
            ? ImageLiterals.AnswerDetail.fireEmpathyLargeInactivated
            : ImageLiterals.AnswerDetail.fireEmpathyLargeActivated
            button.configuration = config
        })
    }
    
    func setTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
}
