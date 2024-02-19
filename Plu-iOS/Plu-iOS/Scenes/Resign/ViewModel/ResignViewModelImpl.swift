//
//  ResignViewModelImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation
import Combine

final class ResignViewModelImpl: ResignViewModel {
    var delegate: ResignNavigation?
    private let manager: ResignManager
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(manager: ResignManager) {
        self.manager = manager
    }
    
    func transform(input: ResignViewModelInput) -> ResignViewModelOutput {
        input.navigationBackButtonTapped
            .sink { [weak self] _ in
                self?.delegate?.backButtonTapped()
            }
            .store(in: &cancelBag)
        
        input.resignButtonTapped
            .sink { [weak self] _ in
                self?.delegate?.resignButtonTapped()
            }
            .store(in: &cancelBag)
        
        
//        Publishers.Merge(input.navigationBackButtonTapped,
//                         input.reuseButtonTapped)
//        .sink { [weak self] _ in
//            self?.delegate?.pop()
//        }
//        .store(in: &cancelBag)
//        
//        let resignResult = input.resignButtonTapped
//            .flatMap { _ -> AnyPublisher<LoadingState, Never> in
//                return Future<LoadingState, NetworkError> { promise in
//                    Task {
//                        do {
//                            try await self.manager.resign()
//                            self.delegate?.resignButtonTapped()
//                        } catch {
//                            promise(.failure(error as! NetworkError))
//                        }
//                    }
//                }.catch { error in
//                    return Just(.error(message: "탈퇴에 실패했습니다."))
//                }
//                .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
        
        return ResignViewModelOutput(resignButtonStatePublisher: input.checkBoxButtonTapped.eraseToAnyPublisher())
    }
}
