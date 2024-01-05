//
//  OthersAnswerViewModelImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import Foundation
import Combine

final class OthersAnswerViewModelImpl: OthersAnswerViewModel {
    
    private let adaptor: OthersAnswerNavigation
    private let manager: OthersAnswerManager
    
    private var answer: OthersAnswer?
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(adaptor: OthersAnswerNavigation, manager: OthersAnswerManager) {
        self.adaptor = adaptor
        self.manager = manager
    }
    
    func transform(input: OthersAnswerViewModelInput) -> OthersAnswerViewModelOutput {
        
        input.navigationBackButtonTapped
            .sink { [weak self] _ in
                self?.adaptor.navigationBackButtonTapped()
            }
            .store(in: &cancelBag)
        
        input.tableViewCellTapped
            .sink { [weak self] row in
                guard let id = self?.answer?.answers[row].id else { return }
                self?.adaptor.tableViewCellTapped(id: id)
            }
            .store(in: &cancelBag)
        
        
        let filterButtonTapped = input.filterButtonTapped
        let viewWillAppear = input.viewWillAppear
        
        let answers = filterButtonTapped.merge(with: viewWillAppear)
            .flatMap { type -> AnyPublisher<OthersAnswer, Never> in
                return Future<OthersAnswer, NetworkError> { promise in
                    Task {
                        do {
                            let answer = try await self.manager.getAnswers(filter: type.object)
                            self.answer = answer
                            promise(.success(answer))
                        } catch {
                            promise(.failure(error as! NetworkError))
                        }
                    }
                }.catch { error in
                    return Just(OthersAnswer.empty)
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        return OthersAnswerViewModelOutput(questions: answers)
    }
}
