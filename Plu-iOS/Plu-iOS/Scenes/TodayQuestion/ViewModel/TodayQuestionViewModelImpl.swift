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
    
    private let navigation: TodayQuestionNavigation
    private let manager: TodayQuestionManagerStub
    private let navigationSubject = PassthroughSubject<FlowType, Never>()
    private var cancelBag = Set<AnyCancellable>()
    
    init(navigation: TodayQuestionNavigation, manager: TodayQuestionManagerStub) {
        self.navigation = navigation
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
        
        self.navigationSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] type in
                switch type {
                case .myPage:
                    self?.navigation.navigationRightButtonTapped()
                case .myAnswer:
                    self?.navigation.myAnswerButtonTapped()
                case .otherAnswer:
                    self?.navigation.otherAnswerButtonTapped()
                case .alarmPopUp:
                    self?.navigation.presentAlarmPopUp()
                }
            }
            .store(in: &cancelBag)
        
        input.isShownAlarmPopupSubject
            .map { _ -> Bool in
                self.checkAlarmPopUpUserDefault()
            }
            .filter { $0 }
            .sink { [weak self] _ in
                self?.navigationSubject.send(.alarmPopUp)
            }
            .store(in: &cancelBag)
        
        input.navigationRightButtonTapped
            .sink { [weak self] _ in
                self?.navigationSubject.send(.myPage)
            }
            .store(in: &cancelBag)
        
        input.myAnswerButtonTapped
            .sink { [weak self] _ in
                self?.navigationSubject.send(.myAnswer)
            }
            .store(in: &cancelBag)
        
        input.otherAnswerButtonTapped
            .sink { [weak self] _ in
                self?.navigationSubject.send(.otherAnswer)
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
