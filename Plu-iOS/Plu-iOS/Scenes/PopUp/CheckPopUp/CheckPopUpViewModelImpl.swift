//
//  RegisterPopUpViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/15.
//

import Foundation
import Combine


protocol CheckPopUpViewModel: ViewModel {
    func transform(input: CheckPopUpInput) -> CheckPopUpOutput
}

struct CheckPopUpInput {
    let leftButtonSubject: PassthroughSubject<Void, Never>
    let rightButtonSubject: PassthroughSubject<Void, Never>
}

struct CheckPopUpOutput {}

final class RegisterPopUpViewModelImpl: CheckPopUpViewModel {

    var delegate: CheckPopUpNavigation?
    private let manager: RegisterPopUpManager
    var cancelBag = Set<AnyCancellable>()
    
    private var answer: String?
    
    init(manager: RegisterPopUpManager) {
        self.manager = manager
    }

    func transform(input: CheckPopUpInput) -> CheckPopUpOutput {
        
        input.leftButtonSubject
            .sink { [weak self] _ in self?.delegate?.leftButtonTapped() }
            .store(in: &cancelBag)
        
        input.rightButtonSubject
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
                    Just("에러 발생")
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
            .sink { _ in
                self.delegate?.rightButtonTapped()
            }
            .store(in: &cancelBag)
        
        
        return CheckPopUpOutput()
    }
}

extension RegisterPopUpViewModelImpl {
    func setAnswer(answer: String) {
        self.answer = answer
    }
}
