//
//  AnswerDetailViewModelImpl.swift
//  Plu-iOS
//
//  Created by 황찬미 on 2023/12/21.
//

import Foundation
import Combine

final class AnswerDetailViewModelImpl: AnswerDetailViewModel, AnswerDetailPresentable {

    private let adaptor: AnswerDetailAdaptor
    private let manager: AnswerDetailManager
    
    private var cancelBag = Set<AnyCancellable>()
    
    private var data = AnswerDetailResponse.empty
    private var answerId = 0
    
    init(adaptor: AnswerDetailAdaptor, manager: AnswerDetailManager) {
        self.adaptor = adaptor
        self.manager = manager
    }
    
    func transform(input: AnswerDetailViewModelInput) -> AnswerDetailViewModelOuput {
        // 추후 Id 값 추가 : answerId
        let viewWillAppearResult = input.viewWillAppearSubject
            .flatMap { _ -> AnyPublisher<AnswerDetailResponse, Never> in
                return Future<AnswerDetailResponse, Error> { promise in
                    Task {
                        do {
                            self.data = try await self.manager.answerDetailResponse()
                            promise(.success(self.data))
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
            .map { _ -> EmpthyCountRequest in
                return self.calculateEmpthyCount()
            }
            .flatMap { request -> AnyPublisher<EmpthyCountResponse, Never> in
                return Future<EmpthyCountResponse, Error> { promise in
                    Task {
                        do {
                            try await self.manager.empthyStateReqeust(request: request)
                            promise(.success((EmpthyCountResponse(empthyType: self.data.empathyType,
                                                                  empthyState: request.empthyState,
                                                                  empthyCount: request.empthyCount))))
                        } catch {
                            promise(.failure(error))
                        }
                    }
                }
                .catch { _ in
                    Just(EmpthyCountResponse(empthyType: self.data.empathyType,
                                             empthyState: request.empthyState,
                                             empthyCount: request.empthyCount))
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        input.leftButtonTapped
            .sink { [weak self] _ in
                self?.adaptor.pop()
            }
            .store(in: &cancelBag)
        
        return AnswerDetailViewModelOuput(viewWillAppearResult: viewWillAppearResult,
                                          empathyButtonResult: empathyButtonResult)
    }
    
    func setAnswerId(id: Int) {
        self.answerId = id
    }
}

extension AnswerDetailViewModelImpl {
    private func calculateEmpthyCount() -> EmpthyCountRequest {
        let countType = data.empathyState ? CountType.down : CountType.up
        self.data.empathyState = !self.data.empathyState
        self.data.empathyCount += countType.addValue
        
        return EmpthyCountRequest(empthyState: self.data.empathyState,
                                  empthyCount: self.data.empathyCount)
    }
}
