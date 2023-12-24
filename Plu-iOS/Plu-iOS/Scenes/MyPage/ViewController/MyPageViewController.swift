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

protocol MyPagePresentable {
    var tableData: [[MyPageSection]] { get set }
}

protocol MyPageViewModel: ViewModel where Input == MypageInput, Output == MypageOutput {}

struct MypageInput {
    var navigationSubject: PassthroughSubject<MypageNavigationType, Never>
    var viewWillAppearSubject: PassthroughSubject<Void, Never>
}

struct MypageOutput {
    var viewWillAppearPublisher: AnyPublisher<MyPageUserData, Never>
    var switchOnSubject: PassthroughSubject<Void, Never>
}

protocol MyPageNavigation {
    var delegate: MyPageAdatporDelegate? { get set }
    func navigation(from type: MypageNavigationType)
//    func backButtonTapped()
//    func myPageHeaderTapped()
//    func resignCellTapped()
//    func logoutCellTapped()
//    func alarmSwitchOff()
//    func faqCellTapped()
//    func openSourceCellTapped()
//    func privacyCellTapped()
}

protocol MyPageManager {
    func getUserData() async throws -> MyPageUserData
}

final class MyPageManagerStub: MyPageManager {
    func getUserData() async throws -> MyPageUserData {
        return .dummyData
    }
}

protocol MyPageAdatporDelegate: AnyObject {
    func isAccept()
}

final class MypageAdaptor: MyPageNavigation {

    weak var delegate: MyPageAdatporDelegate?
    
    var coorinator: MyPageCoordinator
    init(coorinator: MyPageCoordinator) {
        self.coorinator = coorinator
        setDelegate()
    }
    
    func navigation(from type: MypageNavigationType) {
        switch type {
        case .header:
            self.coorinator.showProfileEditViewController()
        case .back:
            self.coorinator.pop()
        case .resign:
            self.coorinator.showResignViewController()
        case .logout:
            print("로그아웃이 눌림")
        case .alarm:
            self.coorinator.presentAlarmPopUpViewController()
        case .faq:
            print("faq가 눌림")
        case .openSource:
            print("오픈소스가 눌림")
        case .privacy:
            print("개인정보가 눌림")
        }
    }
    
    private func setDelegate() {
        self.coorinator.delegate = self
    }
}

extension MypageAdaptor: MypageAlarmResultDelegate {
    func isAccept() {
        self.delegate?.isAccept()
    }
}

final class MypageViewModelImpl: MyPageViewModel, MyPagePresentable {
    var tableData: [[MyPageSection]] = []
    let switchOnSubject = PassthroughSubject<Void, Never>()
    var cancelBag = Set<AnyCancellable>()
    var adaptor: MyPageNavigation
    let manager: MyPageManager
    
    init(adaptor: MyPageNavigation, manager: MyPageManager) {
        self.adaptor = adaptor
        self.manager = manager
        setDelegate()
    }
    
    func transform(input: MypageInput) -> MypageOutput {
        
        let viewWillAppearPublisher: AnyPublisher<MyPageUserData, Never> = input.viewWillAppearSubject
            .requestAPI(failure: .errorDummy) { _ in
                let userData = try await self.manager.getUserData()
                self.tableData = self.setTableViewDataFromUserData(userData.acceptAlarm, userData.appVersion)
                return userData
            } errorHandler: { error in
                print(error)
            }
        
        input.navigationSubject
            .sink { type in
                self.adaptor.navigation(from: type)
            }
            .store(in: &cancelBag)
        
        return MypageOutput(viewWillAppearPublisher: viewWillAppearPublisher, switchOnSubject: switchOnSubject)
    }
    
    private func setTableViewDataFromUserData(_ alarmAccept: Bool, _ appVersion: String?) -> [[MyPageSection]] {
        return MyPageSection.makeMypageData(alarmAccept, appVersion)
    }
    
    private func setDelegate() {
        self.adaptor.delegate = self
    }
}

extension MypageViewModelImpl: MyPageAdatporDelegate {
    func isAccept() {
        self.switchOnSubject.send(())
    }
}

final class MyPageViewController: UIViewController {
    var viewModel: any MyPageViewModel & MyPagePresentable
    
    let navigationSubject = PassthroughSubject<MypageNavigationType, Never>()
    let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    let switchOnSubject = PassthroughSubject<Void, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    private let navigationBar = PLUNavigationBarView()
        .setTitle(text: "마이페이지")
        .setLeftButton(type: .back)
    
    private let myPageTableView = MyPageTableView()
    
    init(viewModel: some MyPageViewModel & MyPagePresentable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearSubject.send(())
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        bindInput()
        setTabBar()
        bind()

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

    func setTabBar() {
        self.tabBarController?.tabBar.isHidden = true
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
                    case .moveSetting:
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
