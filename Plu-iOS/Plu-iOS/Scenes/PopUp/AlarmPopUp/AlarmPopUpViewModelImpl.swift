//
//  AlarmPopUpViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/15.
//

import Foundation
import Combine

protocol AlarmPopUpViewModel {
    func transform(input: AlarmPopUpInput) -> AlarmPopUpOutput
}

struct AlarmPopUpInput {
    let viewDidLoadSubject: PassthroughSubject<Void, Never>
    let buttonSubject: PassthroughSubject<AlarmPopUpViewController.ButtonType, Never>
}

struct AlarmPopUpOutput {
    let viewDidLoadPublisher: AnyPublisher<AlarmDescription, Never>
}

struct AlarmDescription {
    let title: String
    let subTitle: String
    let acceptButtonTitle: String
    let rejectButtonTitle: String
    
    init(type: AlarmType) {
        switch type {
        case .todayQuestion:
            self.title = StringConstant.PopUp.TodayQuestionAlarm.title
            self.subTitle = StringConstant.PopUp.TodayQuestionAlarm.subTitle
            self.acceptButtonTitle = StringConstant.PopUp.TodayQuestionAlarm.acceptButtonTitle
            self.rejectButtonTitle = StringConstant.PopUp.TodayQuestionAlarm.rejectButtonTitle
        case .mypage:
            self.title = StringConstant.PopUp.MypageAlarm.title
            self.subTitle = StringConstant.PopUp.MypageAlarm.subTitle
            self.acceptButtonTitle = StringConstant.PopUp.MypageAlarm.acceptButtonTitle
            self.rejectButtonTitle = StringConstant.PopUp.MypageAlarm.rejectButtonTitle
        }
    }
}

final class AlarmPopUpViewModelImpl: AlarmPopUpViewModel {
    
    let coordinator: PopUpCoordinator
    var cancelBag = Set<AnyCancellable>()
    let type: AlarmType
    
    init(coordinator: PopUpCoordinator, type: AlarmType) {
        self.coordinator = coordinator
        self.type = type
    }

    func transform(input: AlarmPopUpInput) -> AlarmPopUpOutput {
        input.buttonSubject
            .sink { type in
                switch type {
                case .reject:
                    self.coordinator.dismiss()
                case .accept:
                    self.coordinator.accept(type: .alarm(.mypage))
                }
            }
            .store(in: &cancelBag)
        
        let viewDidLoadPublisher = input.viewDidLoadSubject
            .map { _ -> AlarmDescription in
                return AlarmDescription(type: self.type)
            }
            .eraseToAnyPublisher()
        return AlarmPopUpOutput(viewDidLoadPublisher: viewDidLoadPublisher)
    }
}
