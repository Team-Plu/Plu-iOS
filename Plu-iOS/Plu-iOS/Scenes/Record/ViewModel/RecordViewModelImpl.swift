//
//  RecordViewModelImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/21/23.
//

import Foundation
import Combine

final class RecordViewModelImpl: RecordViewModel {
    
    private let adaptor: RecordNavigation
    private let manager: RecordManager
    
    private var cancelBag = Set<AnyCancellable>()
    
    private var questions: [Question]?
    
    init(adaptor: RecordNavigation, manager: RecordManager) {
        self.adaptor = adaptor
        self.manager = manager
    }
    
    func transform(input: RecordViewModelInput) -> RecordViewModelOutput {
        input.filterButtonTapped
            .sink { [weak self] _ in
                self?.adaptor.dateFilterButtonTapped()
            }
            .store(in: &cancelBag)
        
        input.tableViewCellTapped
            .sink { [weak self] row in
                guard let id = self?.questions?[row].id else { return }
                self?.adaptor.tableViewCellTapped(id: id)
            }
            .store(in: &cancelBag)
        
        input.navigationRightButtonTapped
            .sink { [weak self] _ in
                self?.adaptor.navigationRightButtonTapped()
            }
            .store(in: &cancelBag)
        
        let viewWillAppear = input.viewWillAppear
        let filterYearAndMonth = adaptor.yearAndMonthSubject
        
        let questions = viewWillAppear.merge(with: filterYearAndMonth)
            .flatMap { date -> AnyPublisher<[Question], Never> in
                return self.makeQuestionsFuture(date: date)
            }
            .eraseToAnyPublisher()
        
        return RecordViewModelOutput(questions: questions)
    }
    
    private func makeQuestionsFuture(date: FilterDate?) -> AnyPublisher<[Question], Never> {
        return Future<[Question], NetworkError> { promise in
            Task {
                do {
                    let questions = try await self.getRecords(by: date)
                    self.questions = questions
                    promise(.success(questions))
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }.catch { error in
            return Just([])
        }
        .eraseToAnyPublisher()
    }
    
    private func getRecords(by date: FilterDate?) async throws -> [Question] {
        if let date {
            return try await self.manager.getRecordsByDate(by: date)
        }
        return try await self.manager.getRecords()
    }
    
}
