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

struct AlarmPopUpOutput {}

//struct AlarmDescription {
//    let title: String
//    let subTitle: String
//    let acceptButtonTitle: String
//    let rejectButtonTitle: String
//    
//    init(type: AlarmType) {
//        switch type {
//        case .todayQuestion:
//            self.title = StringConstant.PopUp.TodayQuestionAlarm.title
//            self.subTitle = StringConstant.PopUp.TodayQuestionAlarm.subTitle
//            self.acceptButtonTitle = StringConstant.PopUp.TodayQuestionAlarm.acceptButtonTitle
//            self.rejectButtonTitle = StringConstant.PopUp.TodayQuestionAlarm.rejectButtonTitle
//        case .mypage:
//            self.title = StringConstant.PopUp.MypageAlarm.title
//            self.subTitle = StringConstant.PopUp.MypageAlarm.subTitle
//            self.acceptButtonTitle = StringConstant.PopUp.MypageAlarm.acceptButtonTitle
//            self.rejectButtonTitle = StringConstant.PopUp.MypageAlarm.rejectButtonTitle
//        }
//    }
//}

protocol AlaramNavigation: AnyObject {
    func alarmContinueButtonTapped()
    func alarmCancelButtonTapped()
    
}

final class AlarmPopUpViewModelImpl: AlarmPopUpViewModel {
    
    var delegate: AlaramNavigation?
    var cancelBag = Set<AnyCancellable>()

    func transform(input: AlarmPopUpInput) -> AlarmPopUpOutput {
        input.buttonSubject
            .sink { type in
                switch type {
                case .reject:
                    self.delegate?.alarmCancelButtonTapped()
                case .accept:
                    self.delegate?.alarmContinueButtonTapped()
                }
            }
            .store(in: &cancelBag)
        
        return AlarmPopUpOutput()
    }
}
