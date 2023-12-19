//
//  NicknameEditViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/11.
//

import Foundation
import Combine

protocol NicknameEditViewModel {
    func transform(input: NicknameEditInput) -> NicknameEditOutput
}

struct NicknameEditInput {
    let textFieldSubject: AnyPublisher<String, Never>
    let naviagtionLeftButtonTapped: PassthroughSubject<Void, Never>
    let naviagtionRightButtonTapped: PassthroughSubject<String?, Never>
}

struct NicknameEditOutput {
    let nickNameResultPublisher: AnyPublisher<NicknameState, Never>
    let loadingViewSubject: AnyPublisher<LoadingState, Never>
}

enum LoadingState {
    case start, end, error
}

final class NicknameEditViewModelImpl: NicknameEditViewModel, NicknameCheck {
    var nickNameManager: NicknameManager
    var coordinator: MyPageCoordinator
    
    var vaildNicknameSubject = textFieldVaildChecker()
    let navigationSubject = PassthroughSubject<Void, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    init(nickNameManager: NicknameManager, coordinator: MyPageCoordinator) {
        self.nickNameManager = nickNameManager
        self.coordinator = coordinator
    }

    func transform(input: NicknameEditInput) -> NicknameEditOutput {
        
        let loadingViewSubject = input.naviagtionRightButtonTapped
            .flatMap { newNickname -> AnyPublisher<LoadingState, Never> in
                return Future<LoadingState, Error> { promise in
                    Task {
                        do {
                            try await Task.sleep(nanoseconds: 1000000000)
                            try await self.nickNameManager.changeNickName(newNickname: newNickname)
                            self.navigationSubject.send(())
                            promise(.success(.end))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { error in
                    Just(.error)
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        
        input.naviagtionLeftButtonTapped
            .sink { [weak self] in
                self?.navigationSubject.send(())
            }
            .store(in: &cancelBag)
        
        self.navigationSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.coordinator.pop()
            }
            .store(in: &cancelBag)
        
        let nicknameInput = input.textFieldSubject
        let checker = self.vaildNicknameSubject
        let nickNameResultPublisher = self.makeNicknameResultPublisher(from: nicknameInput, to: checker, with: nickNameManager)
        return NicknameEditOutput(nickNameResultPublisher: nickNameResultPublisher, loadingViewSubject: loadingViewSubject)
    }
}
