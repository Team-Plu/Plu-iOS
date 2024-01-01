//
//  MyPageViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation
import Combine

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
        
        input.alarmSwitchTapped.merge(with: input.backButtonTapped, input.faqCellTapped, input.headerTapped, input.openSourceCellTapped, input.privacyCellTapped, input.resignCellTapped)
            .sink { type in
                self.adaptor.navigation(from: type)
            }
            .store(in: &cancelBag)
        
        input.logoutCellTapped
            .requestAPI(failure: print("gg")) { _ in
                try await self.manager.logout()
                self.adaptor.navigation(from: .logout)
            } errorHandler: { error in
                print(error)
            }
            .sink { _ in }
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

extension MypageViewModelImpl: MyPageAdaptorDelegate {
    func isAccept() {
        self.switchOnSubject.send(())
    }
}
