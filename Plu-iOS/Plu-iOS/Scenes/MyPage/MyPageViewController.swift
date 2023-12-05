//
//  MyPageViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//  Copyright (c) 2023 MyPage. All rights reserved.
//

import UIKit

import SnapKit

struct MyPageUserData {
    let nickName: String
    let acceptAlarm: Bool
    let appVersion: String
}

struct MyPageAlarmCellData {
    let title: String
    let acceptAlarm: Bool
}

struct MypageInfomationCellData {
    let title: String
}

struct MypageAppVersionCellData {
    let title: String
    let appVersion: String?
}

enum MyPageSection {
    case alarm(MyPageAlarmCellData)
    case info(MypageInfomationCellData)
    case other(MypageAppVersionCellData)
}

final class MyPageViewController: UIViewController {
    
    var tableData: [[MyPageSection]] = []
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let headerView = MyPageHeaderView(frame: .init(x: 0, y: 0, width: ScreenConstant.Screen.width, height: 100))
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setTableView()
        setMyPageFromUserData(input: .init(nickName: "Plu님", acceptAlarm: true, appVersion: "1.0.0"))
    }
    
    func setMyPageFromUserData(input: MyPageUserData) {
        headerView.configure(input.nickName)
        tableData = setTableViewDataFromUserData(input.acceptAlarm, input.appVersion)
        tableView.reloadData()
    }
    
    private func setTableViewDataFromUserData(_ alarmAccept: Bool, _ appVersion: String?) -> [[MyPageSection]] {
        return [[.alarm(.init(title: "알림 설정", acceptAlarm: alarmAccept))],
                [.info(.init(title: "FAQ")),
                 .info(.init(title: "오픈소스 라이브러리")),
                 .info(.init(title: "개인정보 보호 및 약관"))],
                [.other(.init(title: "앱버전", appVersion: appVersion)),
                 .other(.init(title: "탈퇴하기", appVersion: nil))]]
    }
}

private extension MyPageViewController {
    func setUI() {
        view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        view.addSubview(tableView)
    }
    
    func setLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setTableView() {
        tableView.sectionFooterHeight = 0
        tableView.backgroundColor = .designSystem(.background)
        tableView.tableHeaderView = headerView
        MyPageAlarmTableViewCell.register(to: tableView)
        MyPageNavigationTableViewCell.register(to: tableView)
        MyPageOtherTableViewCell.register(to: tableView)
        tableView.register(MyPageRoundSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: MyPageRoundSectionHeaderView.identifier)
        tableView.register(MyPageSeperateSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: MyPageSeperateSectionHeaderView.identifier)
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
            cell.configure(data)
            return cell
        case .info(let data):
            let cell = MyPageNavigationTableViewCell.dequeueReusableCell(to: tableView)
            cell.configure(data)
            return cell
        case .other(let data):
            let cell = MyPageOtherTableViewCell.dequeueReusableCell(to: tableView)
            cell.configure(data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableData[indexPath.section][indexPath.row] {
        case .alarm: return 62
        case .info: return 52
        case .other: return 78
        }
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = tableData[section].first else { return UIView() }
        switch section {
        case .alarm:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageRoundSectionHeaderView.identifier)
            return header
        case .info, .other:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageSeperateSectionHeaderView.identifier)
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = tableData[section].first else { return 0 }
        switch section {
        case .alarm: return 32
        case .info, .other: return 16
        }
    }
}
