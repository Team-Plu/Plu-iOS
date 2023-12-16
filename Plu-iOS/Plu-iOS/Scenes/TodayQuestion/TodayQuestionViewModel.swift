//
//  TodayQuestionViewModel.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/16.
//

import Foundation
import Combine

final class TodayQuestionViewModel {
    
    struct TodayQuestionViewModelInput {
        let isShownAlarmPopupSubject: PassthroughSubject<Void, Never>
    }
    
    struct TodayQuestionViewModelOutput {
        let isShownAlarmPopupSubject: AnyPublisher<Bool, Never>
    }
    
    func transform(input: TodayQuestionViewModelInput) -> TodayQuestionViewModelOutput {
        let isShownAlarmPopupSubject = input.isShownAlarmPopupSubject
            .map { _ -> Bool in
                let isShownAlarmPopup = UserDefaultsManager.isShownAlarmPopup
                
                if isShownAlarmPopup == false {
                    UserDefaultsManager.isShownAlarmPopup = true
                    return true
                }
                
                return false
            }
            .filter { $0 }
            .eraseToAnyPublisher()
        
        return TodayQuestionViewModelOutput(isShownAlarmPopupSubject: isShownAlarmPopupSubject)
    }
}
