//
//  MyPageViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 MyPage. All rights reserved.
//

import UIKit
import Combine

import SnapKit

enum MypageNavigationType {
    case back, nicknameEdit, resign, logout, popUp, faq, openSource, privacy
}

final class MyPageViewController: UIViewController {
    
    var tableData: [[MyPageSection]] = []
    
    let coordinator: MyPageCoordinator
    
    let navigationSubject = PassthroughSubject<MypageNavigationType, Never>()
    let switchOnSubject = PassthroughSubject<Void, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    private let navigationBar = PLUNavigationBarView()
        .setTitle(text: "마이페이지")
        .setLeftButton(type: .back)
    
    private let myPageTableView = MyPageTableView()
    
    init(coordinator: MyPageCoordinator) {
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
        bindInput()
        setMyPageFromUserData(input: .dummyData)
        self.tabBarController?.tabBar.isHidden = true
        navigationSubject
            .sink { type in
                switch type {
                case .back:
                    self.coordinator.pop()
                case .nicknameEdit:
                    self.coordinator.showProfileEditViewController()
                case .resign:
                    self.coordinator.showResignViewController()
                case .logout:
                    print("로그아웃버튼눌림")
                case .popUp:
                    self.coordinator.presentAlarmPopUpViewController()
                case .faq:
                    print("faq눌림")
                case .openSource:
                    print("오픈소스 눌림")
                case .privacy:
                    print("약관 눌림")
                }
            }
            .store(in: &cancelBag)
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
    
    func setDelegate() {
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.myPageHeaderDelgate = self
        self.coordinator.delegate = self
    }
    
    func setMyPageFromUserData(input: MyPageUserData) {
        myPageTableView.setTableHeader(nickName: input.nickName)
        tableData = setTableViewDataFromUserData(input.acceptAlarm, input.appVersion)
        myPageTableView.reloadData()
    }
    
    func setTableViewDataFromUserData(_ alarmAccept: Bool, _ appVersion: String?) -> [[MyPageSection]] {
        return MyPageSection.makeMypageData(alarmAccept, appVersion)
    }
    
    func bindInput() {
        self.navigationBar.leftButtonTapSubject
            .sink { [weak self] in
                self?.navigationSubject.send(.back)
            }
            .store(in: &cancelBag)
    }
}

extension MyPageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableData[indexPath.section][indexPath.row] {
        case .alarm(let data):
            let cell = MyPageAlarmTableViewCell.dequeueReusableCell(to: tableView)
            
            cell.alarmSwitchTypeSubject
                .sink { [weak self] type in
                    switch type {
                    case .alarmAccept:
                        self?.navigationSubject.send(.popUp)
                    case .moveSetting:
                        self?.goToSettingPage()
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
        switch tableData[indexPath.section][indexPath.row] {
        case .alarm: return MyPageCellHeight.alarmCellHeight
        case .info, .exit: return MyPageCellHeight.infoCellHeight
        case .appVersion: return MyPageCellHeight.appVersionCellHeight
        }
    }
}

extension MyPageViewController: UITableViewDelegate, MyPageHeaderDelgate {
    func headerDidTapped() {
        self.coordinator.showProfileEditViewController()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = tableData[section].first else { return UIView() }
        if case .alarm = section {
            return MyPageRoundSectionHeaderView.dequeueReusableSectionHeaderView(to: tableView)
        }
        let seperateView = UIView()
        seperateView.backgroundColor = .designSystem(.background)
        return seperateView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = tableData[section].first else { return 0 }
        if case .alarm = section {
            return MyPageSectionHeaderHeight.alarmSectionHeaderHeight
        }
        return MyPageSectionHeaderHeight.seperateSectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = tableData[indexPath.section][indexPath.row]
        if case .info(let type) = cellType {
            self.navigationSubject.send(type.changeToMyPageNavigation)
        }
        if case .exit(let type) = cellType {
            self.navigationSubject.send(type.changeToMyPageNavigation)
        }
    }
}

extension MyPageViewController: MypageAlarmResultDelegate {
    func isAccept() {
        self.switchOnSubject.send(())
    }
}
