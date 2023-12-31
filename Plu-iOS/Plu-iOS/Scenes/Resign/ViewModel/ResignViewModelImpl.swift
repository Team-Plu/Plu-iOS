//
//  ResignViewModelImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation
import Combine

final class ResignViewModelImpl: ResignViewModel {
    private let adaptor: ResignNavigation
    private let manager: ResignManager
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(adaptor: ResignNavigation, manager: ResignManager) {
        self.adaptor = adaptor
        self.manager = manager
    }
    
    func transform(input: ResignViewModelInput) -> ResignViewModelOutput {
        Publishers.Merge(input.navigationBackButtonTapped,
                         input.reuseButtonTapped)
        .sink { [weak self] _ in
            self?.adaptor.pop()
        }
        .store(in: &cancelBag)
        
        let resignResult = input.resignButtonTapped
            .flatMap { _ -> AnyPublisher<LoadingState, Never> in
                return Future<LoadingState, NetworkError> { promise in
                    Task {
                        do {
                            try await self.manager.resign()
                            self.adaptor.resignButtonTapped()
                        } catch {
                            promise(.failure(error as! NetworkError))
                        }
                    }
                }.catch { error in
                    return Just(.error(message: "탈퇴에 실패했습니다."))
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return ResignViewModelOutput(resignResult: resignResult)
    }
}
