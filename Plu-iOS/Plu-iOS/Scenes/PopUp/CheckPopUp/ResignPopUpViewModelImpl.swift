//
//  ResignPopUpViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2/19/24.
//

import Foundation
import Combine

final class ResignPopUpViewModelImpl: CheckPopUpViewModel {

    var delegate: CheckPopUpNavigation?
    private let manager: ResignManager
    var cancelBag = Set<AnyCancellable>()
    
    private var answer: String?
    
    init(manager: ResignManager) {
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
                            try await self.manager.resign()
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
