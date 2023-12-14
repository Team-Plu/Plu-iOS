//
//  MyPageViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 MyPage. All rights reserved.
//

import UIKit

import SnapKit

final class MyPageViewController: UIViewController {
    
    var tableData: [[MyPageSection]] = []
    
    let coordinator: MyPageCoordinator
    
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
        setMyPageFromUserData(input: .dummyData)
    }
}

private extension MyPageViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubview(myPageTableView)
    }
    
    func setLayout() {
        myPageTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setDelegate() {
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        myPageTableView.myPageHeaderDelgate = self
    }
    
    func setMyPageFromUserData(input: MyPageUserData) {
        myPageTableView.setTableHeader(nickName: input.nickName)
        tableData = setTableViewDataFromUserData(input.acceptAlarm, input.appVersion)
        myPageTableView.reloadData()
    }
    
    func setTableViewDataFromUserData(_ alarmAccept: Bool, _ appVersion: String?) -> [[MyPageSection]] {
        return MyPageSection.makeMypageData(alarmAccept, appVersion)
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
            cell.configureUI(data)
            return cell
        case .info(let data):
            let cell = MyPageGeneralTableViewCell.dequeueReusableCell(to: tableView)
            cell.configureUI(data)
            return cell
        case .appVersion(let data):
            let cell = MyPageAppVersionTableViewCell.dequeueReusableCell(to: tableView)
            cell.configureUI(data)
            return cell
        case .exit(let data):
            let cell = MyPageGeneralTableViewCell.dequeueReusableCell(to: tableView)
            cell.configureUI(data)
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
        print("\(indexPath.section+1)번째 section의 \(indexPath.row+1)번째 cell이 눌렸습니다")
        switch tableData[indexPath.section][indexPath.row] {
        case .exit(let data):
            if data.title == "탈퇴하기" {
                self.coordinator.showResignViewController()
            }
        default:
            print("딴거")
        }
    }
}
