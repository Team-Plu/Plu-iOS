//
//  RegisterPopUpViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/15.
//

import Foundation
import Combine

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
        
        let viewDidLoadPublisher = Just(CheckPopUpText(title: StringConstant.PopUp.Register.title,
                                                       subTitle: StringConstant.PopUp.Register.subTitle,
                                                       leftButtonTitle: StringConstant.PopUp.Register.checkButtonTitle,
                                                       rightButtonTitle: StringConstant.PopUp.Register.registerButtonTitle))
        
        return CheckPopUpOutput(viewDidLoadPublisher: viewDidLoadPublisher.eraseToAnyPublisher())
    }
}

extension RegisterPopUpViewModelImpl {
    func setAnswer(answer: String) {
        self.answer = answer
    }
}
