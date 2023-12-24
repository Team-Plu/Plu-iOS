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
    private let leftButtonTapped = PassthroughSubject<Void, Never>()
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let empathyButtonTappedSubject = PassthroughSubject<Void, Never>()
    
    private let viewModel: any AnswerDetailViewModel

    private let navigationBar = PLUNavigationBarView()
        .setLeftButton(type: .back)
    private let everyAnswerView = PLUEverydayAnswerView()
    private let contentView = UIView()
    private let answerScrollerView = UIScrollView()
    private let answerDetailLabel = PLULabel(type: .body1R, color: .gray700, backgroundColor: .background, lines: 0, text: "진정한 행복이란 추석 연휴에 엽떡을 먹는 것 엽떡은 정말 맛있기 때문입니다 엽떡 만세진정한 행복이란 추석 연휴에 엽떡을 먹는 것 엽떡은 정말 맛있기 때문입니다")
    private let sympathyButton = PLUButton(config: .bordered())
        .setImage(image: ImageLiterals.AnswerDetail.airEmpathyLargeActivated, placement: .leading, padding: 4)
        .setLayer(cornerRadius: 15, borderColor: .pluRed)
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setHierarchy()
        setLayout()
        bindInput()
        bind()
        setTabBar()
    }
    
    init(viewModel: some AnswerDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearSubject.send(())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindInput() {
        navigationBar.leftButtonTapSubject
            .sink { [weak self] _ in
                guard let self else { return }
                self.leftButtonTapped.send(())
            }
            .store(in: &cancleBag)
        
        sympathyButton.tapPublisher
            .sink { [weak self] _ in
                guard let self else { return }
                self.empathyButtonTappedSubject.send(())
            }
            .store(in: &cancleBag)
    }
    
    private func bind() {
        let output = viewModel.transform(input: AnswerDetailViewModelInput(leftButtonTapped: leftButtonTapped,
                                                                           viewWillAppearSubject: viewWillAppearSubject,
                                                                           empathyButtonTappedSubject: empathyButtonTappedSubject))
        
        output.viewWillAppearResult
            .sink { [weak self] response in
                guard let self else { return }
                self.updateUI(response: response)
            }
            .store(in: &cancleBag)
        
        output.empathyButtonResult
            .sink { [weak self] response in
                guard let self else { return }
                self.setButtonHandler(type: response.empthyType,
                                      count: response.empthyCount,
                                      state: response.empthyState)
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
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setButtonHandler(type: Elements, count: Int, state: Bool) {
        sympathyButton.setUpdateHandler { button in
            var config = button.configuration
            var attrString = AttributedString("공감 \(count)")
            attrString.font = .suite(.body2M)
            config?.attributedTitle = attrString
            
            config?.baseBackgroundColor = state
            ? .designSystem(type.color)
            : .designSystem(.white)
            
            config?.baseForegroundColor = state
            ? .designSystem(.white)
            : .designSystem(type.color)
            
            config?.image = state
            ? type.activeEmpathy
            : type.inActiveEmpathy
            
            button.configuration = config
            
            button.layer.borderColor = state
            ? .designSystem(.white)
            : .designSystem(type.color)
        }

    }
    
    func setTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func updateUI(response: AnswerDetailResponse) {
        everyAnswerView.configureUI(date: response.date, question: response.question)
        answerDetailLabel.text = response.answer
        setButtonHandler(type: response.empathyType, count: response.empathyCount, state: response.empathyState)
    }
}
