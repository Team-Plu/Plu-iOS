//
//  MyPageViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/24.
//

import Foundation
import Combine

final class MyPageViewModel {
    
    struct Input {
        let headerTapped: PassthroughSubject<MypageNavigationType, Never>
        let faqCellTapped: PassthroughSubject<MypageNavigationType, Never>
        let backButtonTapped: PassthroughSubject<MypageNavigationType, Never>
        let resignCellTapped: PassthroughSubject<MypageNavigationType, Never>
        let logoutCellTapped: PassthroughSubject<Void, Never>
        let alarmSwitchTapped: PassthroughSubject<MypageNavigationType, Never>
        let openSourceCellTapped: PassthroughSubject<MypageNavigationType, Never>
        let privacyCellTapped: PassthroughSubject<MypageNavigationType, Never>
        var viewWillAppearSubject: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        var viewWillAppearPublisher: AnyPublisher<MyPageUserData, Never>
        var switchOnSubject: PassthroughSubject<Void, Never>?
    }

//    let switchOnSubject = PassthroughSubject<Void, Never>()
    var cancelBag = Set<AnyCancellable>()
    var delegate: MyPageNavigation?
    let manager: MyPageManager
    
    init(manager: MyPageManager) {
        self.manager = manager
    }
    
    @MainActor
    func transform(input: Input) -> Output {
        
        let viewWillAppearPublisher: AnyPublisher<MyPageUserData, Never> = input.viewWillAppearSubject
            .requestAPI(failure: .errorDummy) { _ in
                let userData = try await self.manager.getUserData()
                return userData
            } errorHandler: { error in
                print(error)
            }
        
        input.alarmSwitchTapped.merge(with: input.backButtonTapped, input.faqCellTapped, input.headerTapped, input.openSourceCellTapped, input.privacyCellTapped, input.resignCellTapped)
            .sink { type in
                self.delegate?.navigation(from: type)
            }
            .store(in: &cancelBag)
        
        input.logoutCellTapped
            .requestAPI(failure: print("gg")) { _ in
                try await self.manager.logout()
                self.delegate?.navigation(from: .logout)
            } errorHandler: { error in
                print(error)
            }
            .sink { _ in }
            .store(in: &cancelBag)
        
        
        return Output(viewWillAppearPublisher: viewWillAppearPublisher, switchOnSubject: self.delegate?.popUpCheckSubject)
    }
}
