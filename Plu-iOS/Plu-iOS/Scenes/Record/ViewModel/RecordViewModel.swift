//
//  RecordViewModel.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/21/23.
//

import Foundation
import Combine

protocol RecordViewModel: ViewModel where Input == RecordViewModelInput, Output == RecordViewModelOutput {}

struct RecordViewModelInput {
    let viewWillAppear: PassthroughSubject<FilterDate?, Never>
    let tableViewCellTapped: PassthroughSubject<Int, Never>
    let filterButtonTapped: PassthroughSubject<Void, Never>
    let navigationRightButtonTapped: PassthroughSubject<Void, Never>
}

struct RecordViewModelOutput {
    let questions: AnyPublisher<[Question], Never>
    let selectYearAndMonthPublisehr: PassthroughSubject<FilterDate, Never>?
}

