//
//  MyPageViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 MyPage. All rights reserved.
//

import UIKit
import Combine

import Carbon
import SnapKit

final class MyPageViewController: UIViewController {
    
    private enum MypageType { case profile, alarm, info, version, user }
    
    // 임시변수 추후 뷰모델로 이동
    var isOn = false
    
    let headerTapped = PassthroughSubject<MypageNavigationType, Never>()
    let faqCellTapped = PassthroughSubject<MypageNavigationType, Never>()
    let backButtonTapped = PassthroughSubject<MypageNavigationType, Never>()
    let resignCellTapped = PassthroughSubject<MypageNavigationType, Never>()
    let logoutCellTapped = PassthroughSubject<Void, Never>()
    let alarmSwitchTapped = PassthroughSubject<MypageNavigationType, Never>()
    let openSourceCellTapped = PassthroughSubject<MypageNavigationType, Never>()
    let privacyCellTapped = PassthroughSubject<MypageNavigationType, Never>()
    let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    let switchOnSubject = PassthroughSubject<Void, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    var viewModel: any MyPageViewModel & MyPagePresentable
    
    private let navigationBar = PLUNavigationBarView()
        .setTitle(text: StringConstant.Navibar.title.myPage)
        .setLeftButton(type: .back)
    
    private let myPageTableView = UITableView(frame: .zero, style: .grouped)
    private let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
    init(viewModel: some MyPageViewModel & MyPagePresentable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        setHierarchy()
        setLayout()
        bindInput()
        bind()
        render()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.viewWillAppearSubject.send(())
    }
    

    func render() {
        renderer.render {
            Section(id: MypageType.profile) {
                ProfileItem(nickname: "Plu님") {
                    self.headerTapped.send(.header)
                }
            }
            
            Section(id: MypageType.alarm) {
                RoundHeadItem()
                AlarmSettingItem(isOn: self.isOn) { type in
                    switch type {
                    case .alarmAccept:
                        self.alarmSwitchTapped.send(.alarm)
                    case .alarmReject:
                        self.goToSettingPage { _ in
                            self.isOn = false
                            self.render()
                        }
                    }
                }
            }
            
            Section(id: MypageType.info) {
                SpaceItem(16)
                MyPageItem(title: "FAQ") {
                    self.faqCellTapped.send(.faq)
                }
                MyPageItem(title: "오픈소스 라이브러리") {
                    self.openSourceCellTapped.send(.openSource)
                }
                MyPageItem(title: "개인정보 보호 및 약관") {
                    self.privacyCellTapped.send(.privacy)
                }
            }
            
            Section(id: MypageType.version) {
                SpaceItem(16)
                AppversionItem(version: "1.0.0")
            }
            
            Section(id: MypageType.user) {
                SpaceItem(16)
                MyPageItem(title: "로그아웃") {
                    self.logoutCellTapped.send(())
                }
                MyPageItem(title: "탈퇴하기") {
                    self.resignCellTapped.send(.resign)
                }
            }
        }
    }
    
}

private extension MyPageViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar, myPageTableView)
    }
    
    func setLayout() {
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        myPageTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func bindInput() {
        self.navigationBar.leftButtonTapSubject
            .sink { [weak self] in
                self?.backButtonTapped.send(.back)
            }
            .store(in: &cancelBag)
    }
    
    func bind() {
        let input = MypageInput(headerTapped: self.headerTapped,
                                faqCellTapped: self.faqCellTapped,
                                backButtonTapped: self.backButtonTapped,
                                resignCellTapped: self.resignCellTapped,
                                logoutCellTapped: self.logoutCellTapped,
                                alarmSwitchTapped: self.alarmSwitchTapped,
                                openSourceCellTapped: self.openSourceCellTapped,
                                privacyCellTapped: self.privacyCellTapped,
                                viewWillAppearSubject: self.viewWillAppearSubject)
        
        let output = viewModel.transform(input: input)
        
        output.viewWillAppearPublisher
            .receive(on: DispatchQueue.main)
            .sink { userData in
                print(userData)
            }
            .store(in: &cancelBag)
        
        output.switchOnSubject
            .sink { _ in
                self.switchOnSubject.send(())
            }
            .store(in: &cancelBag)
    }
    
    func setTableView() {
        myPageTableView.separatorStyle = .none
        renderer.target = myPageTableView
    }
}
