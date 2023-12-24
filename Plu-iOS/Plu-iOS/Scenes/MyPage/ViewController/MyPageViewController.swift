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

final class MyPageViewController: UIViewController {

    let navigationSubject = PassthroughSubject<MypageNavigationType, Never>()
    let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    let switchOnSubject = PassthroughSubject<Void, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    var viewModel: any MyPageViewModel & MyPagePresentable
    
    private let navigationBar = PLUNavigationBarView()
        .setTitle(text: StringConstant.Navibar.title.myPage)
        .setLeftButton(type: .back)
    
    private let myPageTableView = MyPageTableView()
    
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
        setHierarchy()
        setLayout()
        setDelegate()
        bindInput()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearSubject.send(())
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
    }
    
    func setMyPageFromUserData(input: MyPageUserData) {
        myPageTableView.setTableHeader(nickName: input.nickName)
        myPageTableView.reloadData()
    }
    
    func bindInput() {
        self.navigationBar.leftButtonTapSubject
            .sink { [weak self] in
                self?.navigationSubject.send(.back)
            }
            .store(in: &cancelBag)
    }
    
    func bind() {
        let input = MypageInput(navigationSubject: navigationSubject, viewWillAppearSubject: viewWillAppearSubject)
        let output = viewModel.transform(input: input)
        
        output.viewWillAppearPublisher
            .receive(on: DispatchQueue.main)
            .sink { userData in
                self.setMyPageFromUserData(input: userData)
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
                        self?.navigationSubject.send(.alarm)
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
        self.navigationSubject.send(.header)
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
            self.navigationSubject.send(type.changeToMyPageNavigation)
        }
        if case .exit(let type) = cellType {
            self.navigationSubject.send(type.changeToMyPageNavigation)
        }
    }
}
