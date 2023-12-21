//
//  AnswerDetailViewModelImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import Foundation
import Combine

final class AnswerDetailViewModelImpl: AnswerDetailViewModel {
    
    private let adaptor: AnswerDetailAdaptor
    private let manager: AnswerDetailManager
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(adaptor: AnswerDetailAdaptor, manager: AnswerDetailManager) {
        self.adaptor = adaptor
        self.manager = manager
    }
    
    func transform(input: AnswerDetailViewModelInput) -> AnswerDetailViewModelOuput {
        let viewWillAppearResult = input.viewWillAppearSubject
            .flatMap { _ -> AnyPublisher<AnswerDetailResponse, Never> in
                return Future<AnswerDetailResponse, Error> { promise in
                    Task {
                        do {
                            let response = try await self.manager.answerDetailResponse()
                            promise(.success(response))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { _ in
                    Just(AnswerDetailResponse.empty)
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        let empathyButtonResult = input.empathyButtonTappedSubject
            .map { (request, type) -> EmpthyCountRequest in
                switch type {
                case .up:
                    return EmpthyCountRequest(empthyState: !request.empthyState,
                                              empthyCount: request.empthyCount+1)
                case .down:
                    return EmpthyCountRequest(empthyState: !request.empthyState,
                                              empthyCount: request.empthyCount-1)
                }
            }
            .flatMap { request -> AnyPublisher<EmpthyCountResponse, Never> in
                return Future<EmpthyCountResponse, Error> { promise in
                    Task {
                        do {
                            try await self.manager.empthyStateReqeust(request: request)
                            promise(.success((EmpthyCountResponse(empthyState: request.empthyState,
                                                                  empthyCount: request.empthyCount))))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { _ in
                    Just(EmpthyCountResponse(empthyState: false, empthyCount: 0))
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        input.leftButtonTapped
            .sink { _ in
                self.adaptor.pop()
            }
            .store(in: &cancelBag)
        
        return AnswerDetailViewModelOuput(viewWillAppearResult: viewWillAppearResult,
                                          empathyButtonResult: empathyButtonResult)
    }
}
