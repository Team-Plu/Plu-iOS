//
//  RegisterPopUpViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/15.
//

import Foundation
import Combine

protocol RegisterPopUpPresentable {
    func setAnswer(answer: String)
}

protocol RegisterPopUpViewModel: ViewModel {
    func transform(input: RegisterPopUpInput) -> RegisterPopUpOutput
}

struct RegisterPopUpInput {
    let buttonSubject: PassthroughSubject<RegisterPopUpViewController.ButtonType, Never>
}

struct RegisterPopUpOutput {}

final class RegisterPopUpViewModelImpl: RegisterPopUpViewModel, RegisterPopUpPresentable {

    private let adaptor: RegisterPopUpNavigation
    private let manager: RegisterPopUpManager
    var cancelBag = Set<AnyCancellable>()
    
    private var answer: String?
    
    init(adaptor: RegisterPopUpNavigation, manager: RegisterPopUpManager) {
        self.adaptor = adaptor
        self.manager = manager
    }

    func transform(input: RegisterPopUpInput) -> RegisterPopUpOutput {
        
        input.buttonSubject
            .sink { type in
                switch type {
                case .reCheck:
                    self.adaptor.dismiss()
                default:
                    break
                }
            }
            .store(in: &cancelBag)
        
        input.buttonSubject
            .filter { type -> Bool in
                type == .register
            }
            .flatMap { type -> AnyPublisher<String, Never> in
                return Future<String, Error> { promise in
                    Task {
                        do {
                            try await self.manager.resgisterAnswer()
                            promise(.success("성공"))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { error in
                    Just("실패임 ㅋㅋ")
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
            .sink { _ in
                self.adaptor.completeButtonTapped()
            }
            .store(in: &cancelBag)
        
        
        return RegisterPopUpOutput()
    }
}

extension RegisterPopUpViewModelImpl {
    func setAnswer(answer: String) {
        self.answer = answer
    }
}
