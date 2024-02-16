//
//  TodayQuestionViewModel.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/16.
//

import Foundation
import Combine

final class TodayQuestionViewModelImpl: TodayQuestionViewModel {
    
    enum FlowType {
        case myPage, myAnswer, otherAnswer, alarmPopUp
    }
    
    var delegate: TodayQuestionNavigation?
    private let manager: TodayQuestionManagerStub
    private var cancelBag = Set<AnyCancellable>()
    
    init(manager: TodayQuestionManagerStub) {
        self.manager = manager
    }
    
    func transform(input: TodayQuestionViewModelInput) -> TodayQuestionViewModelOutput {
        
        let viewWillAppearSubject = input.viewWillAppearSubject
            .flatMap { _ -> AnyPublisher<TodayQuestionResponse, Never> in
                return Future<TodayQuestionResponse, Error> { promise in
                    Task {
                        do {
                            let response = try await self.manager.getTodayQuestionResponse()
                            promise(.success(response))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { error in
                    Just(TodayQuestionResponse.empty)
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        input.isShownAlarmPopupSubject
            .map { _ -> Bool in
                self.checkAlarmPopUpUserDefault()
            }
            .filter { $0 }
            .sink { [weak self] _ in
                self?.delegate?.presentAlarmPopUp()
            }
            .store(in: &cancelBag)
        
        input.navigationRightButtonTapped
            .sink { [weak self] _ in
                self?.delegate?.navigationRightButtonTapped()
            }
            .store(in: &cancelBag)
        
        input.myAnswerButtonTapped
            .sink { [weak self] _ in
                self?.delegate?.myAnswerButtonTapped()
            }
            .store(in: &cancelBag)
        
        input.otherAnswerButtonTapped
            .sink { [weak self] _ in
                self?.delegate?.otherAnswerButtonTapped()
            }
            .store(in: &cancelBag)
        
        return Output(viewWillAppearSubject: viewWillAppearSubject)
    }
}

extension TodayQuestionViewModelImpl {
    private func checkAlarmPopUpUserDefault() -> Bool {
        let isShownAlarmPopup = UserDefaultsManager.isShownAlarmPopup
        
        if isShownAlarmPopup == false {
            UserDefaultsManager.isShownAlarmPopup = true
            return true
        }
        
        return false
    }
}
