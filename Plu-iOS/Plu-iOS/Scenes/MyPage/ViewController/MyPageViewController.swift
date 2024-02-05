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
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())
    
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
    
    func setTableView() {
        myPageTableView.separatorStyle = .none
        renderer.target = myPageTableView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearSubject.send(())
    }
    
    enum MypageType {
        case profile, alarm, info, version, user
    }
    func render() {
        renderer.render {
            
            Section(id: MypageType.profile) {
                ProfileItem(nickname: "Plu님") {
                    print("프로필눌림")
                }
            }
            
            Section(id: MypageType.alarm) {
                RoundHeadItem()
                
                AlarmSettingItem(isOn: true) { type in
                    switch type {
                    case .alarmAccept:
                        self.alarmSwitchTapped.send(.alarm)
                    case .alarmReject:
                        self.goToSettingPage { _ in
                            print("✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
                            
                        }
                    }
                }
            }
            
            Section(id: MypageType.info) {
                SpaceItem(16)
                MyPageItem(title: "FAQ") {
                    print("FAQ가 눌림")
                }
                
                MyPageItem(title: "오픈소스 라이브러리") {
                    print("오픈소스 라이브러리가 눌림")
                }
                
                MyPageItem(title: "개인정보 보호 및 약관") {
                    print("개인정보 보호 및 약관이 눌림")
                }
            }
            
            Section(id: MypageType.version) {
                SpaceItem(16)
                
                AppversionItem(version: "1.0.0")
            }
            
            Section(id: MypageType.user) {
                SpaceItem(16)
                
                MyPageItem(title: "로그아웃") {
                    print("로그아웃이 눌림")
                }
                
                MyPageItem(title: "탈퇴하기") {
                    print("탈퇴하기가 눌림")
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

}

extension MyPageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.viewModel.tableData[indexPath.section][indexPath.row] {
        case .alarm(let data):
            let cell = MyPageAlarmTableViewCell.dequeueReusableCell(to: tableView)
            
            cell.alarmSwitchTypeSubject
                .sink { [weak self] type in
                    switch type {
                    case .alarmAccept:
                        self?.alarmSwitchTapped.send(.alarm)
                    case .alarmReject:
                        self?.goToSettingPage { _ in 
                            cell.alarmSwitch.setOn(false, animated: false)
                        }
                    }
                }
                .store(in: &cell.cancelBag)
            
            self.switchOnSubject.sink {
                cell.alarmSwitch.isOn = true
            }
            .store(in: &cell.cancelBag)
            
            cell.configureUI(data)
            return cell
        case .info(let type):
            let cell = MyPageGeneralTableViewCell.dequeueReusableCell(to: tableView)
            cell.configureUI(type.title)
            return cell
        case .appVersion(let data):
            let cell = MyPageAppVersionTableViewCell.dequeueReusableCell(to: tableView)
            cell.configureUI(data)
            return cell
        case .exit(let type):
            let cell = MyPageGeneralTableViewCell.dequeueReusableCell(to: tableView)
            cell.configureUI(type.title)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.viewModel.tableData[indexPath.section][indexPath.row] {
        case .alarm: return MyPageCellHeight.alarmCellHeight
        case .info, .exit: return MyPageCellHeight.infoCellHeight
        case .appVersion: return MyPageCellHeight.appVersionCellHeight
        }
    }
}

extension MyPageViewController: UITableViewDelegate, MyPageHeaderDelgate {
    func headerDidTapped() {
        self.headerTapped.send(.header)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = self.viewModel.tableData[section].first else { return UIView() }
        if case .alarm = section {
            return MyPageRoundSectionHeaderView.dequeueReusableSectionHeaderView(to: tableView)
        }
        let seperateView = UIView()
        seperateView.backgroundColor = .designSystem(.background)
        return seperateView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = self.viewModel.tableData[section].first else { return 0 }
        if case .alarm = section {
            return MyPageSectionHeaderHeight.alarmSectionHeaderHeight
        }
        return MyPageSectionHeaderHeight.seperateSectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = self.viewModel.tableData[indexPath.section][indexPath.row]
        if case .info(let type) = cellType {
            switch type {
            case .faq:
                self.faqCellTapped.send(type.changeToMyPageNavigation)
            case .openSource:
                self.openSourceCellTapped.send(type.changeToMyPageNavigation)
            case .privacy:
                self.openSourceCellTapped.send(type.changeToMyPageNavigation)
            }
        }
        if case .exit(let type) = cellType {
            switch type {
            case .logout:
                self.logoutCellTapped.send(())
            case .resign:
                self.resignCellTapped.send(type.changeToMyPageNavigation)
            }
        }
    }
}
