//
//  OnboardingViewModelImpl.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/19.
//

import Foundation
import Combine

final class OnboardingViewModelImpl: OnboardingViewModel, NicknameCheck {
    
    enum OnboardingFlowType {
        case backButtonTapped, signInButtonTapped
    }

    var nickNameManager: NicknameManager
    var adaptor: OnboardingNavigation
    var vaildNicknameSubject = textFieldVaildChecker()
    var navigationSubject = PassthroughSubject<OnboardingFlowType, Never>()
    let signInStatePublisher = PassthroughSubject<LoadingState, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    init(manager: NicknameManager, adaptor: OnboardingNavigation) {
        self.nickNameManager = manager
        self.adaptor = adaptor
    }
    
    func transform(input: OnboardingInput) -> OnboardingOutput {
        
        let nicknameInput = input.textFieldSubject
        let checker = self.vaildNicknameSubject
        let nickNameResultPublisher = self.makeNicknameResultPublisher(from: nicknameInput, to: checker, with: nickNameManager)
        
        self.navigationSubject
            .receive(on: DispatchQueue.main)
            .sink { type in
                switch type {
                case .backButtonTapped:
                    self.adaptor.backButtonTapped()
                case .signInButtonTapped:
                    self.adaptor.signInButtonTapped()
                }
            }
            .store(in: &cancelBag)
        
        input.backButtonTapped
            .sink { _ in
                self.navigationSubject.send(.backButtonTapped)
            }
            .store(in: &cancelBag)
        
        /// 만약에 LoadingState를 따로 publish하는 publisher가 있다면 vc입장에선 loadingview의 시작시점에대한 아무런 관심이없어짐
        /// 이렇게 하면 버튼 action을 따로 sink를 해줘야함(publish를 위한 단순 sink)
        /// 근데 buttonTap의 output이 LoadingState라면 publisher자체를 vc에서 구독할거라서 위의 찜찜함이 없어짐
        /// 하지만 이렇게하면 promise에서 state인 .end를 보내줘야하기에 navigation이후에 .end가 보내짐 그러면 애초에 view가 바뀌어버리니까 의미가없어지는게 아닌가 싶음
        /// 그리고 promise가 불리면 stream의 completion block이 호출되기에 start와 end를 둘다 호출할 수 없어 end만 보내야함
        /// 근데 이방식은 너무 많은 일을 하는듯한 느낌이 듦
        input.singInButtonTapped
            .flatMap { nickname -> AnyPublisher<Void, Never> in
                return Future<Void, Error> { promise in
                    Task {
                        do {
                            self.signInStatePublisher.send(.start)
                            try await Task.sleep(nanoseconds: 100_000_000_0)
                            try await self.nickNameManager.registerUser(nickName: nickname)
                            self.signInStatePublisher.send(.end)
                            self.navigationSubject.send(.signInButtonTapped)
                            promise(.success(()))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { _ in
                    Just(())
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
            .sink {}
            .store(in: &cancelBag)
    
        
        return OnboardingOutput(nickNameResultPublisher: nickNameResultPublisher, signInStatePublisher: signInStatePublisher)
    }
}


